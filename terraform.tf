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

module "flows" {
  source = "./modules/flows"
  # ... other arguments
}


