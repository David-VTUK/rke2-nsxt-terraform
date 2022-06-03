output "nsxt_cluster_node" {
    value = rancher2_cluster_sync.cluster_sync.nodes[0].annotations
}
