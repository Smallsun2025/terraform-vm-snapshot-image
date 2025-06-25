variable "resource_group_name" {
  description = "Name of the resource group where the existing VM is located"
  type        = string
}

variable "os_disk_name" {
  description = "Name of the existing OS disk of the VM"
  type        = string
}

variable "snapshot_name" {
  description = "Name to give the snapshot"
  type        = string
}

variable "image_name" {
  description = "Name to assign to the new managed image"
  type        = string
}
