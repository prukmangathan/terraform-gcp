locals {
  name              = "${var.prefix}-${var.app_id}-${var.environment}-${format("%.2s", random_id.uuid.dec)}"
  network_ip        = concat(var.network_ip, ["NOT_AN_IP"])
  network_interface = length(format("%s%s", var.network, var.subnetwork)) == 0 ? [] : [1]
}

resource "random_id" "uuid" {
  keepers = {
    seed = "${var.prefix}-${var.app_id}-${var.environment}"
  }
  byte_length = 8
}

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


  dynamic "boot_disk" {
    for_each = var.boot_disk

    content {
      auto_delete             = lookup(boot_disk.value, "auto_delete", null)
      device_name             = lookup(boot_disk.value, "device_name", null)
      mode                    = lookup(boot_disk.value, "mode", null)
      disk_encryption_key_raw = lookup(boot_disk.value, "disk_encryption_key_raw", null)
      kms_key_self_link       = lookup(boot_disk.value, "kms_key_self_link", null)
      source                  = lookup(boot_disk.value, "source", null)
      dynamic "initialize_params" {
        for_each = var.disk_image
        content {
          size  = lookup(image.value, "size", null)
          type  = lookup(image.value, "type", null)
          image = lookup(image.value, "image", null)
        }
      }
    }
  }

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

network_interface {
    network            = var.network
    subnetwork         = var.subnetwork
    subnetwork_project = var.subnetwork_project
    network_ip         = length(var.network_ip) == 0 ? "" : element(local.network_ip, count.index)
    dynamic "access_config" {
      for_each = var.access_config
      content {
        nat_ip       = access_config.value.nat_ip
        network_tier = access_config.value.network_tier
      }
    }
  }

  service_account {
    email  = var.service_account_email
    scopes = ["cloud-platform"]
  }
}