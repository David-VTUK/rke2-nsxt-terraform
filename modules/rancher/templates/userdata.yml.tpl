#cloud-config
runcmd:
  - ${BOOTSTRAP_COMMAND} --etcd --controlplane --worker
  - mkdir -p /opt/cni/bin
  - wget -c https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-amd64-v1.1.1.tgz -O - | tar -xz -C /opt/cni/bin
packages:
 - python