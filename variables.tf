variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region to deploy resources in"
  type        = string
}

variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "node_count" {
  description = "Number of nodes in the AKS node pool"
  type        = number
}

variable "vm_size" {
  description = "Size of the VMs for the AKS nodes"
  type        = string
}

