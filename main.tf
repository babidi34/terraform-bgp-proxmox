terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.51.0"
    }
  }
}

provider "proxmox" {
  endpoint = "https://192.168.1.120:8006"
  api_token = var.api_token
  insecure = true
  ssh {
    agent    = false
    username = "root"
    private_key = file(var.ssh_private_key)
  }
}

resource "proxmox_virtual_environment_vm" "vm" {
  for_each = var.vms

  name      = each.value.name
  node_name = each.value["node_name"]

  clone {
    vm_id = data.proxmox_virtual_environment_vms.template[each.key].vms[0].vm_id
    }

  dynamic "cpu" {
    for_each = lookup(each.value, "cpu", {}) != {} ? [lookup(each.value, "cpu", {})] : []
    content {
      cores   = cpu.value["cores"]
      sockets = lookup(cpu.value, "sockets", 1)
      type    = lookup(cpu.value, "type", "host")
    }
  }

  dynamic "memory" {
    for_each = lookup(each.value, "memory", {}) != {} ? [lookup(each.value, "memory", {})] : []
    content {
      dedicated = memory.value["dedicated"]
    }
  }

  dynamic "disk" {
    for_each = lookup(each.value, "disks", [])

    content {
      datastore_id = disk.value["datastore_id"]
      size         = lookup(disk.value, "size", 30)
      file_format  = lookup(disk.value, "file_format", "qcow2")
      interface    = lookup(disk.value, "interface", "scsi")
      iothread     = lookup(disk.value, "iothread", false)
      discard      = lookup(disk.value, "discard", "ignore")
    }
  }


  dynamic "network_device" {
    for_each = lookup(each.value, "network_devices", [])

    content {
      bridge    = network_device.value["bridge"]
      model     = lookup(network_device.value, "model", "virtio")
      mac_address = lookup(network_device.value, "mac_address", null)
      rate_limit  = lookup(network_device.value, "rate_limit", 0)
      vlan_id     = lookup(network_device.value, "vlan_id", null)
      # Ajoute d'autres configurations réseau ici si nécessaire.
    }
  }
  initialization {
    ip_config {
      ipv4 {
        address = lookup(each.value.ip_config, "ipv4_address", "dhcp")
        gateway = lookup(each.value.ip_config, "ipv4_gateway", null)
      }
    }
    user_account {
      keys     = lookup(each.value, "ssh_key_pub", null)
      password = lookup(each.value, "password", random_password.vm_password.result)
      username = lookup(each.value, "username", null)
    }
  }
}

resource "random_password" "vm_password" {
  length           = 16
  override_special = "_%@"
  special          = true
}
