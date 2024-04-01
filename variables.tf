variable "api_token" {
  description = "Token to connect Proxmox API"
  type = string
}

variable "vms" {
  description = "Les configurations des VMs"
  type        = any
  default     = {}
}
