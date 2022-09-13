locals {
  name = "${var.prefix}-${var.app_id}-${var.environment}-${format("%.2s", random_id.uuid.dec)}"
}

resource "random_id" "uuid" {
  keepers = {
    seed = "${var.prefix}-${var.app_id}-${var.environment}"
  }
  byte_length = 8
}

resource "google_compute_instance" "main" {
  #project      = var.project_id
  name         = local.name
  hostname     = var.hostname
  machine_type = var.machine_type
  zone         = var.zone

  tags = var.tags

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = var.network

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = var.metadata

  metadata_startup_script = var.metadata_startup_script

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = var.service_account_email
    scopes = ["cloud-platform"]
  }
}