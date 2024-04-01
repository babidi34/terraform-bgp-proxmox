vms = {
  "vm1" = {
    name         = "debian-karim-terraform"
    node_name    = "gon"
    template_tag = "debian-12"
    cpu          = {
      cores        = 4
    }
    memory       = {
      dedicated = 2048
    }
    disk       = [{
      datastore_id = "local-lvm"
      size         = 50
    }]
    ip_config = {
      ipv4_address = "192.168.1.180/24"
      ipv4_gateway = "192.168.1.254"
    }
  },
  "vm2" = {
    name         = "debian-karim-terraform2"
    node_name    = "gon"
    template_tag = "debian-12"
    cpu          = {
      cores        = 1
      architecture = "x86_64"
    }
    memory       = {
      dedicated = 1024
    }
    network_device = {
      bridge   = "vmbr0"
      firewall = true
      model    = "e1000"
    }
    disk       = [{
      datastore_id = "local-lvm"
    }]
    ip_config = {
      ipv4_address = "192.168.1.181/24"
      ipv4_gateway = "192.168.1.254"
    }
  }
}
