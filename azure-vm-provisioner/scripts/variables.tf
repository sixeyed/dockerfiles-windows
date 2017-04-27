# Settings

variable "resource_group" {
  description = "Name of the resource group to use for VMs"
  type = "string"
}

variable "storage_account" {
  description = "Name of the storage account to use for VMs"
  type = "string"
}

variable "dns_prefix" {
  description = "DNS prefix for VM public addreses"
  type = "string"
}

variable "region" {
  description = "Azure region to use"
  type = "string"
}

variable "image_vhd_uri" {
  description = "URI of the sysprepped VHD to use as the VM image"
  type = "string"
}

variable "usernames" {
  description = "Usernames for the VM admin accounts"
  type = "list"
  default = [
    "user-abc"
  ]
}

variable "passwords" {
  description = "Passwords for the VM admin accounts"
  type = "list"
}

variable "vm_count" {
  description = "Number of VMs to create"
  type = "string"
  default = "1"
}

variable "vm_size" {
  description = "VM size to create"
  type = "string"
  default = "Standard_D2_v2"
}

variable "azure_dns_suffix" {
    description = "Azure DNS suffix for public addresses"
    default = "cloudapp.azure.com"
}