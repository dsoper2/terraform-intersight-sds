# Intersight Provider Information 
terraform {
  required_providers {
    intersight = {
      source  = "ciscodevnet/intersight"
      version = ">= 0.1.0"
    }
  }
}

provider "intersight" {
  apikey        = var.api_key_id
  secretkeyfile = var.api_private_key
  endpoint      = var.api_endpoint
}

module "get_moids" {
  source = "./get_moids"
}

resource "intersight_server_profile" "storage-node1" {
  name = "storage-node1"
  organization {
    object_type = "organization.Organization"
    moid        = module.get_moids.organization_moid
  }

  assigned_server {
    moid        = module.get_moids.server_moid
    object_type = "compute.RackUnit"
  }
  action = var.server_profile_action

}