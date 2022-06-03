data "rancher2_cloud_credential" "vsphere-credentials" {
  name = "nsxt-vsphere"
}

resource "rancher2_machine_config_v2" "vsphere-nsxt-mc" {
  generate_name = "mc-nsxt"
  vsphere_config {
    cloud_config = file("${path.module}/userdata.yaml")
    clone_from  = var.vm_template_name
    creation_type = "template"
    cpu_count   = var.vm_template_num_cpu
    datacenter  = var.vm_datacenter
    disk_size   = var.vm_template_disk_size
    memory_size = var.vm_mem_size
    datastore   = var.vm_datastore
    network     = var.vm_network_list
    hostsystem = "p-esxi2.virtualthoughts.co.uk"
  }
}

resource "rancher2_cluster_v2" "nsxt_cluster" {
  name               = var.k8s_clustername
  kubernetes_version = "v1.22.9+rke2r2"
  rke_config {
     machine_global_config = <<EOF
      cni: none
      EOF
      
    machine_pools {
      name                         = "aio"
      cloud_credential_secret_name = data.rancher2_cloud_credential.vsphere-credentials.id
      control_plane_role           = true
      etcd_role                    = true
      worker_role                  = true
      quantity                     = 1
      machine_config {
        kind = rancher2_machine_config_v2.vsphere-nsxt-mc.kind
        name = rancher2_machine_config_v2.vsphere-nsxt-mc.name

      }
    }
  } 
}



# Create a new rancher2 Cluster Sync
resource "rancher2_cluster_sync" "cluster_sync" {
  cluster_id =  rancher2_cluster_v2.nsxt_cluster.cluster_v1_id
}
  

resource "local_file" "kubeconfig" {
    content  = rancher2_cluster_v2.nsxt_cluster.kube_config
    filename = "kubeconfig.yaml"
}


