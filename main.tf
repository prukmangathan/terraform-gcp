locals {
  uscentral1 = [
    {
      zone = "us-central1-a"
    },
    {
      zone = "us-central1-b"
    }
  ]

  useast1 = [
    {
      zone = "us-east1-a"
    },
    {
      zone = "us-east1-b"
    }
  ]
}

provider "google" {
  credentials = file("credentials.json")
  region      = "us-central1"
  project     = "dazzling-matrix-361211"
}

provider "google" {
  credentials = file("credentials.json")
  region      = "us-east1"
  project     = "dazzling-matrix-361211"
  alias       = "east"
}

resource "google_service_account" "default" {
  account_id   = "sa-ci-vm-1234"
  display_name = "sa-ci-vm-1234"
}

module "compute_instance_us_central1" {
  source = "./modules/compute_instance"
  for_each = { for region in local.uscentral1: region.zone => region}
  zone   = each.value.zone

  prefix      = "tax"
  app_id      = "loans"
  environment = var.environment

  machine_type          = "e2-medium"
  image                 = "debian-cloud/debian-11"
  service_account_email = google_service_account.default.email
}

module "compute_instance_us_east1" {
  source = "./modules/compute_instance"
  for_each = { for region in local.useast1: region.zone => region}
  zone   = each.value.zone

  prefix      = "tax"
  app_id      = "loans"
  environment = var.environment

  machine_type          = "e2-medium"
  image                 = "debian-cloud/debian-11"
  service_account_email = google_service_account.default.email

  providers = {
    google = google.east
  }
}
  
