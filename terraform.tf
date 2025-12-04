terraform {
  required_providers {
    genesyscloud = {
      source = "MyPureCloud/genesyscloud"
      version = "1.72.2"
    }
  }
}

provider "genesyscloud" {
  oauthclient_id = "${var.oauth_client}"
  oauthclient_secret = "${var.oauth_secret}"
  aws_region = "${var.aws_region}"
}

data "genesyscloud_auth_division" "home" {
  name        = "Home"
}

resource "genesyscloud_routing_wrapupcode" "NewOrder" {
  name        = "New Order"
  description = "New Order test description"
}

resource "random_uuid" "example_uuid" {}

resource "genesyscloud_group" "TestGroup" {
  name          = "Test Group"
  description   = "Group for Testers"
  type          = "official"
  visibility    = "public"
  rules_visible = true
  addresses {
    number = "+13174181234"
    type   = "GROUPRING"
  }
  owner_ids      = ["4eff594a-b2f6-494e-804d-bb77780c53d6"]
  member_ids     = ["4eff594a-b2f6-494e-804d-bb77780c53d6"]
  roles_enabled  = true
  calls_enabled  = false
  include_owners = false
}

resource "genesyscloud_script" "NewOrderScript" {
  script_name       = "Example script name ${random_uuid.example_uuid.result}"
  filepath          = "${var.working_dir.script}/MenuScript.script.json"
  file_content_hash = filesha256("${var.working_dir.script}/MenuScript.script.json")
  substitutions = {
    /* Inside the script file, "{{foo}}" will be replaced with "bar" */
    foo = "bar"
  }
}

resource "genesyscloud_routing_queue" "Suresh_Example_Queue" {
  name                     = "Suresh Example Queue"
  division_id              = data.genesyscloud_auth_division.home.id
  description              = "This is an example description"
  acw_wrapup_prompt        = "MANDATORY_TIMEOUT"
  acw_timeout_ms           = 300000
  skill_evaluation_method  = "BEST"
  queue_flow_id            = "037f2416-0bfc-4172-afe1-18a8989cae7e"
  whisper_prompt_id        = "26ac8b8f-df81-4791-ad57-503ab25ea78d"
  auto_answer_only         = true
  enable_transcription     = true
  enable_audio_monitoring  = true
  enable_manual_assignment = true
  calling_party_name       = "KFC"
  groups                   = [genesyscloud_group.TestGroup.id]

  media_settings_call {
    alerting_timeout_sec      = 30
    service_level_percentage  = 0.7
    service_level_duration_ms = 10000
  }

  routing_rules {
    operator     = "MEETS_THRESHOLD"
    threshold    = 9
    wait_seconds = 300
  }

  default_script_ids = {
    EMAIL = genesyscloud_script.NewOrderScript.id
    # CHAT  = data.genesyscloud_script.chat.id
  }

  wrapup_codes = [genesyscloud_routing_wrapupcode.NewOrder.id]
}

