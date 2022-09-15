terraform {
  backend "gcs" {
    bucket = "terraform-state-file-7482"
  }
}

provider "google" {
  region  = "us-central1"
  project = var.project_id
}

provider "google" {
  region  = "us-east1"
  project = var.project_id
  alias   = "secondary"
}

resource "google_service_account" "default" {
  account_id   = "sa-ci-vm-1234"
  display_name = "sa-ci-vm-1234"
}

module "compute_instance_us_central1" {
  source   = "./modules/compute_instance"
  for_each = { for instance in var.usc_instance_config : "${instance.zone}-${instance.app_id}" => instance }

  project_id            = var.project_id
  zone                  = each.value.zone
  tags                  = lookup(each.value, "tags", {})
  labels                = lookup(each.value, "labels", {})
  prefix                = "hd"
  app_id                = each.value.app_id
  environment           = var.environment
  machine_type          = "e2-medium"
  disk_image            = lookup(each.value, "disk_image", var.disk_image)
  network               = "default"
  access_config         = lookup(each.value, "access_config", [])
  service_account_email = google_service_account.default.email
}

module "compute_instance_us_east1" {
  source   = "./modules/compute_instance"
  for_each = { for instance in var.use_instance_config : "${instance.zone}-${instance.app_id}" => instance }

  project_id            = var.project_id
  zone                  = each.value.zone
  tags                  = lookup(each.value, "tags", {})
  labels                = lookup(each.value, "labels", {})
  prefix                = "hd"
  app_id                = each.value.app_id
  environment           = var.environment
  machine_type          = "e2-medium"
  disk_image            = each.value.disk_image
  network               = "default"
  access_config         = lookup(each.value, "access_config", [])
  service_account_email = google_service_account.default.email

  providers = {
    google = google.secondary
  }
}