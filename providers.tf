terraform {
  required_providers {
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