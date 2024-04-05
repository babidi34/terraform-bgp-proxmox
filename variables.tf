variable "api_token" {
  description = "Token to connect Proxmox API"
  type = string
}

variable "ssh_private_key" {
  description = "path to ssh private key for connection to pve"
  type = string
}

variable "vms" {
  description = "Les configurations des VMs"
  type        = any
  default     = {}
}

variable "node_name" {
  description = "node name in proxmox"
  type = string
}

variable "datastore_id" {
  description = "datastore_id == datastore name"
  type = string
}
