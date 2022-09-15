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
  prefix                = "hd"
  environment           = var.environment
  machine_type          = "e2-medium"
  network               = "default"
  service_account_email = google_service_account.default.email
  zone                  = each.value.zone
  app_id                = each.value.app_id
  tags                  = lookup(each.value, "tags", {})
  labels                = lookup(each.value, "labels", {})
  access_config         = lookup(each.value, "access_config", [])
  disk_image            = lookup(each.value, "disk_image", var.disk_image)
}

module "compute_instance_us_east1" {
  source   = "./modules/compute_instance"
  for_each = { for instance in var.use_instance_config : "${instance.zone}-${instance.app_id}" => instance }

  project_id            = var.project_id
  prefix                = "hd"
  environment           = var.environment
  machine_type          = "e2-medium"
  network               = "default"
  service_account_email = google_service_account.default.email
  zone                  = each.value.zone
  app_id                = each.value.app_id
  tags                  = lookup(each.value, "tags", {})
  labels                = lookup(each.value, "labels", {})
  access_config         = lookup(each.value, "access_config", [])
  disk_image            = lookup(each.value, "disk_image", var.disk_image)

  providers = {
    google = google.secondary
  }
}