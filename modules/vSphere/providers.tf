terraform {
  required_providers {
    vsphere = {
      source = "hashicorp/vsphere"
      version = "2.1.1"
    }
    nsxt = {
      source  = "vmware/nsxt"
      version = "3.2.7"
    }
    rancher2 = {
      source  = "rancher/rancher2"
      version = "1.24.0"
    }
  }
}