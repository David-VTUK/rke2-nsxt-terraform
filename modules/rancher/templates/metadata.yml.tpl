local-hostname: ${node_hostname}
instance-id: ${node_hostname}
network:
  ethernets:
    ens192:
      dhcp4: true
    ens224:
      dhcp4: true
      dhcp4-overrides:
        use-routes: false
  version: 2
