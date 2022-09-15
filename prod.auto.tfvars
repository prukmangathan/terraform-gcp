environment = "prod"

usc_instance_config = [
  {
    zone   = "us-central1-a",
    app_id = "p41-1",
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
    app_id = "p41-2",
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
    zone   = "us-east1-d",
    app_id = "p41",
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