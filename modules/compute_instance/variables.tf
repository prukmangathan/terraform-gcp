variable "prefix" {
  type        = string
  default     = null
  description = "The prefix for resource name."
}

variable "app_id" {
  type        = string
  default     = null
  description = "The application name."
}

variable "environment" {
  type        = string
  default     = null
  description = "The environment name (dev/qa/prod)."
}

variable "machine_type" {
  type        = string
  default     = null
  description = "Machine type to create, e.g. n1-standard-1"
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "The instance labels."
}

variable "zone" {
  type        = string
  default     = null
  description = "The instance zone."
}

variable "hostname" {
  type        = string
  default     = null
  description = "The instance hostname."
}

variable "tags" {
  type        = list(string)
  default     = []
  description = "The instance tags."
}

variable "network" {
  type        = string
  default     = ""
  description = "The instance network."
}

variable "subnetwork_project" {
  type        = string
  description = "The project that subnetwork belongs to"
  default     = ""
}

variable "subnetwork" {
  type        = string
  description = "Subnet to deploy to. Only one of network or subnetwork should be specified."
  default     = ""
}

variable "metadata" {
  type        = map(string)
  default     = {}
  description = "The instance metadata."
}

variable "metadata_startup_script" {
  type        = string
  default     = "default"
  description = "The instance start up script."
}

variable "service_account_email" {
  type        = string
  default     = "default"
  description = "The instance service account email."
}

variable "project_id" {
  type    = string
  default = null
}

variable "boot_disk" {
  description = "List of maps of disks."
  type        = any
  default     = []
}

variable "disk_image" {
  description = "List of maps of disk image."
  type        = any
  default     = []
}

variable "access_config" {
  description = "Access configurations, i.e. IPs via which the VM instance can be accessed via the Internet."
  type        = any
  default     = []
}

variable "network_ip" {
  description = "Private IP address to assign to the instance if desired."
  default     = ""
}

variable "attached_disk" {
  description = "List of maps of disk image."
  type        = any
  default     = []
}

variable "network_interface" {
  description = "List of maps of network interfaces."
  type        = any
  default     = []
}