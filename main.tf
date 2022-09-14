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

data "google_compute_zones" "primary" {
  project = var.project_id
  region  = "us-central1"
}

data "google_compute_zones" "secondary" {
  project = var.project_id
  region  = "us-east1"
}

resource "random_shuffle" "primary" {
  input        = data.google_compute_zones.primary.names
  result_count = 1
}

resource "random_shuffle" "secondary" {
  input        = data.google_compute_zones.secondary.names
  result_count = 1
}

module "compute_instance_us_central1" {
  source = "./modules/compute_instance"
  count  = length(var.usc_app_ids)
  zone   = random_shuffle.primary.result[0]

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
  zone   = random_shuffle.secondary.result[0]

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