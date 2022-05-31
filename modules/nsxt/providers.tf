terraform {
  required_providers {
    nsxt = {
      source = "vmware/nsxt"
      version = "3.2.7"
    }
  }
}


provider "nsxt" {
  host = var.nsxt_api
  username = var.nsxt_username
  password = var.nsxt_password
  allow_unverified_ssl = true
}




