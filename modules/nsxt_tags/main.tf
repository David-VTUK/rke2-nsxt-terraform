data "vsphere_datacenter" "datacenter" {
  name = var.vm_datacenter
}

data "vsphere_virtual_machine" "vm" {
  name          = var.vm_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "nsxt_policy_vm_tags" "vm1_tags" {

    instance_id = data.vsphere_virtual_machine.vm.id

  port {
    segment_path = var.overlay_segment_path

    tag {
      scope = "ncp/node_name"
      tag = var.vm_name
    }
    tag {
      scope = "ncp/cluster"
      tag = var.k8s_clustername
    }

  }
}