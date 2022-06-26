#cloud-config
runcmd:
  - ${BOOTSTRAP_COMMAND} --etcd --controlplane --worker