# vSphere specific variables

variable "vsphere_user" {
  type        = string
  description = "Username for vSphere authentication"
}
variable "vsphere_password" {
  type        = string
  description = "Password for vSphere authentication"
}
variable "vsphere_server" {
  type        = string
  description = "vCenter server IP or FQDN"
}


# VM specific variables

variable "vm_template_name" {
  type        = string
  description = "Name of the VM template used to create the RKE2 cluster"
}

variable "vm_template_num_cpu" {
  type        = number
  description = "Number of vCPU's to allocate to each RKE2 node VM"
}

variable "vm_template_disk_size" {
  type        = number
  description = "Size (in GB) of the root disk for the RKE2 node VM"
}

variable "vm_datastore" {
  type        = string
  description = "Destination datastore for the RKE2 node VM"
}

variable "vm_datacenter" {
  type        = string
  description = "Name of the vSphere Datacenter object for the RKE2 node VM"
}

variable "vm_resourcepool" {
  type        = string
  description = "Name of the vSphere Resource Pool object for the RKE2 node VM"
}

variable "vm_mem_size" {
  type        = number
  description = "Size (in GB) of the amount of RAM allocated to the RKE2 VM"
}

variable "vm_network_list" {
  type        = list(string)
  description = "List of port groups to attach"
}

# Rancher-specific

variable "rancher2_access_key" {
  type        = string
  description = "Access key for Rancher API access"
}

variable "rancher2_secret_key" {
  type        = string
  description = "Secret key for Rancher API access"
}

variable "rancher2_baseurl" {
  type        = string
  description = "URL for the Rancher API endpoint"
}


variable "k8s_clustername" {
  type = string
  description = "Name of the cluster"
}