vms = {
  "vm1" = {
    name         = "debian11-karim-terraform"
    node_name    = "gon"
    template_tag = "debian-11"
    cpu          = {
      cores        = 4
    }
    memory       = {
      dedicated = 2048
    }
    disks       = [{
      datastore_id = "local-lvm"
      size         = 50
      interface    = "scsi0"
    }]
    ip_config = {
      ipv4_address = "192.168.1.180/24"
      ipv4_gateway = "192.168.1.254"
    }
    username = "linux-man"
    ssh_key_pub     = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINr+Qt/kvbbUymF++edHDvXb7+AWclu64TpW8iLqLW5/ karimbaidi@gmail.com"]
  },
  "vm2" = {
    name         = "debian12-karim-terraform"
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
    disks       = [{
      datastore_id = "local-lvm"
      interface    = "scsi0"
    }]
    ip_config = {
      ipv4_address = "192.168.1.181/24"
      ipv4_gateway = "192.168.1.254"
    }
    username = "linux-man"
    ssh_key_pub     = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINr+Qt/kvbbUymF++edHDvXb7+AWclu64TpW8iLqLW5/ karimbaidi@gmail.com"]

  }
}
node_name = "gon"
datastore_id = "local-lvm"