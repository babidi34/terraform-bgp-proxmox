data "proxmox_virtual_environment_vms" "template" {
  for_each = var.vms

  node_name = each.value.node_name
  tags = [each.value.template_tag]
}

data "proxmox_virtual_environment_datastores" "my_datastores" {
  node_name = var.node_name
}