terraform {
  required_providers {
    nsxt = {
      source  = "vmware/nsxt"
      version = "3.2.7"
    }
    vsphere = {
      source = "hashicorp/vsphere"
      version = "2.1.1"
    }
  }
}


provider "nsxt" {
  host                 = var.nsxt_api
  username             = var.nsxt_username
  password             = var.nsxt_password
  allow_unverified_ssl = true
}


provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}
