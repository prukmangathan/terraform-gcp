variable "environment" {
  type    = string
  default = null
}

variable "usc_instance_config" {
  type    = any
  default = []
}

variable "use_instance_config" {
  type    = any
  default = []
}

variable "project_id" {
  type    = string
  default = "dazzling-matrix-361211"
}

variable "disk_image" {
  description = "List of maps of disk image."
  type        = any
  default     = []
}