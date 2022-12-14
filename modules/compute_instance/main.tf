# Naming convention for instance name
locals {
  name = "${var.prefix}-${var.app_id}-${var.environment}-${format("%.2s", random_id.uuid.dec)}"
}

# Generate random id for resource name
resource "random_id" "uuid" {
  keepers = {
    seed = "${var.prefix}-${var.app_id}-${var.environment}"
  }
  byte_length = 8
}

# Create compute instance
resource "google_compute_instance" "main" {
  project                 = var.project_id
  name                    = local.name
  hostname                = var.hostname
  machine_type            = var.machine_type
  zone                    = var.zone
  metadata                = var.metadata
  tags                    = var.tags
  labels                  = var.labels
  metadata_startup_script = var.metadata_startup_script

  # Boot disk for compute instance 
  boot_disk {
    auto_delete             = var.auto_delete
    device_name             = var.device_name
    mode                    = var.mode
    disk_encryption_key_raw = var.disk_encryption_key_raw
    kms_key_self_link       = var.kms_key_self_link
    source                  = var.disk_source
    dynamic "initialize_params" {
      for_each = var.disk_image
      content {
        size  = lookup(initialize_params.value, "size", null)
        type  = lookup(initialize_params.value, "type", null)
        image = lookup(initialize_params.value, "image", null)
      }
    }
  }

  # Additional disk for compute instance (Optional)
  dynamic "attached_disk" {
    for_each = var.attached_disk

    content {
      device_name             = lookup(attached_disk.value, "device_name", null)
      mode                    = lookup(attached_disk.value, "mode", null)
      disk_encryption_key_raw = lookup(attached_disk.value, "disk_encryption_key_raw", null)
      kms_key_self_link       = lookup(attached_disk.value, "kms_key_self_link", null)
      source                  = lookup(attached_disk.value, "source", null)
    }
  }

  # Network for compute instance
  network_interface {
    network            = var.network
    subnetwork         = var.subnetwork
    subnetwork_project = var.subnetwork_project
    network_ip         = length(var.network_ip) > 0 ? var.network_ip : null
    dynamic "access_config" {
      for_each = var.access_config
      content {
        nat_ip       = access_config.value.nat_ip
        network_tier = lookup(access_config.value, "network_tier", null)
      }
    }
  }

  # Service account for compute instance
  service_account {
    email  = var.service_account_email
    scopes = ["cloud-platform"]
  }
}