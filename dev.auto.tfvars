environment = "dev"

usc_instance_config = [
  {
    zone   = "us-central1-a",
    app_id = "e41-1",
    tags   = ["sap"],
    labels = {
      department = "loans"
    },
    disk_image = [
      {
        size  = 20
        image = "debian-cloud/debian-11"
      }
    ]
  },
  {
    zone   = "us-central1-b",
    app_id = "e41-2",
    tags   = ["sap"],
    labels = {
      department = "loans"
    },
    disk_image = [
      {
        size  = 20
        image = "debian-cloud/debian-11"
      }
    ]
  }
]

use_instance_config = [
  {
    zone   = "us-east1-b",
    app_id = "c41",
    tags   = ["sap"],
    labels = {
      department = "loans"
    },
    disk_image = [
      {
        size  = 20
        image = "debian-cloud/debian-11"
      }
    ]
  }
]