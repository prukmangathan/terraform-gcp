terraform {
  backend "gcs" {
    bucket = "terraform-state-file-7482"
    prefix = "github/terraform-gcp"
  }
}

provider "google" {
  region  = "us-central1"
  project = "dazzling-matrix-361211"
}

provider "google" {
  region  = "us-east1"
  project = "dazzling-matrix-361211"
  alias   = "east"
}

resource "google_service_account" "default" {
  account_id   = "sa-ci-vm-1234"
  display_name = "sa-ci-vm-1234"
}

module "compute_instance_us_central1" {
  source = "./modules/compute_instance"
  count  = length(var.app_ids)
  zone   = "us-central1-a"

  prefix      = "hd"
  app_id      = var.app_ids[count.index]
  environment = var.environment

  machine_type          = "e2-medium"
  image                 = "debian-cloud/debian-11"
  service_account_email = google_service_account.default.email
}

module "compute_instance_us_east1" {
  source = "./modules/compute_instance"
  count  = length(var.app_ids)
  zone   = "us-east1-a"

  prefix      = "tax"
  app_id      = var.app_ids[count.index]
  environment = var.environment

  machine_type          = "e2-medium"
  image                 = "debian-cloud/debian-11"
  service_account_email = google_service_account.default.email

  providers = {
    google = google.east
  }
}