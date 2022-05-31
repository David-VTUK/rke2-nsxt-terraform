resource "rancher2_machine_config_v2" "vsphere-nsxt" {
    generate_name = "mc_nsxt"   
    vsphere_config {
        clone_from = var.vm_template_name
        cpu_count = var.vm_template_num_cpu
        datacenter = var.vm.datacenter
        disk_size = var.vm_template_disk_size
        memory_size = var.vm_mem_size
        datastore = var.vm_datastore

    }
}

