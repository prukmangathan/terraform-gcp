terraform {
  backend "gcs" {
    bucket = "terraform-state-file-7482"
  }
}

provider "google" {
  region  = var.primary_region
  project = var.project_id
}

provider "google" {
  region  = var.secondary_region
  project = var.project_id
  alias   = "secondary"
}

resource "google_service_account" "default" {
  account_id   = "sa-ci-vm-1234"
  display_name = "sa-ci-vm-1234"
}

module "compute_instance_us_central1" {
  source = "./modules/compute_instance"
  count  = length(var.usc_app_ids)
  region = var.primary_region

  prefix      = "hd"
  app_id      = var.usc_app_ids[count.index]
  environment = var.environment

  machine_type          = "e2-medium"
  image                 = "debian-cloud/debian-11"
  service_account_email = google_service_account.default.email
}

module "compute_instance_us_east1" {
  source = "./modules/compute_instance"
  count  = length(var.use_app_ids)
  region = var.secondary_region

  prefix      = "tax"
  app_id      = var.use_app_ids[count.index]
  environment = var.environment

  machine_type          = "e2-medium"
  image                 = "debian-cloud/debian-11"
  service_account_email = google_service_account.default.email

  providers = {
    google = google.secondary
  }
}