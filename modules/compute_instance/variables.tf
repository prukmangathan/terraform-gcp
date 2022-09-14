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
  description = "The instance machine_type."
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

variable "image" {
  type        = string
  default     = null
  description = "The instance image."
}

variable "network" {
  type        = string
  default     = "default"
  description = "The instance network."
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