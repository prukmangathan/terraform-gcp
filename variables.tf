variable "environment" {
  type    = string
  default = null
}

variable "usc_app_ids" {
  type    = list(string)
  default = []
}

variable "use_app_ids" {
  type    = list(string)
  default = []
}

variable "project_id" {
  type    = string
  default = "dazzling-matrix-361211"
}

variable "primary_region" {
  type    = string
  default = "us-central1"
}

variable "secondary_region" {
  type    = string
  default = "us-east1"
}