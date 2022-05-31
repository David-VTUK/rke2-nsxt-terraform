terraform {
  required_providers {
    vsphere = {
      source = "hashicorp/vsphere"
      version = "2.1.1"
    }
    rancher2 = {
      source = "rancher/rancher2"
      version = "1.24.0"
    }
  }
}

provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

provider "rancher2" {
  api_url    = var.rancher2_baseurl
  access_key = var.rancher2_access_key
  secret_key = var.rancher2_secret_key
}



