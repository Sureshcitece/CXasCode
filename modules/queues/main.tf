resource "genesyscloud_routing_queue" "Suresh_Example_Queue" {
  name                     = "Suresh Example Queue"
  division_id              = data.genesyscloud_auth_division.home.id
  description              = "This is an example description"
  acw_wrapup_prompt        = "MANDATORY_TIMEOUT"
  acw_timeout_ms           = 300000
  skill_evaluation_method  = "BEST"
  queue_flow_id            = "31f91941-475c-4d32-8223-901ca38aa2cc"
  whisper_prompt_id        = "26ac8b8f-df81-4791-ad57-503ab25ea78d"
  auto_answer_only         = true
  enable_transcription     = true
  enable_audio_monitoring  = true
  enable_manual_assignment = true
  calling_party_name       = "KFC"
  groups                   = ["0d008fc9-14cf-4fc4-b926-e136e8d9a3b6"]

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

  wrapup_codes = ["7d7e37e7-962c-4eae-a5ac-fed5955e4681"]
}