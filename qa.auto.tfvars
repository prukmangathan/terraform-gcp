environment = "sandbox"

usc_instance_config = [
  {
    zone   = "us-central1-a",
    app_id = "b41",
    tags   = ["sap"],
    labels = {
      department = "loans"
    },
    disk_image = [
      {
        size  = 20 #GB
        image = "debian-cloud/debian-11"
      }
    ]
  },
  {
    zone   = "us-central1-b",
    app_id = "d41",
    tags   = ["sap"],
    labels = {
      department = "loans"
    },
    disk_image = [
      {
        size  = 20 #GB
        image = "debian-cloud/debian-11"
      }
    ]
  }
]

use_instance_config = [
  {
    zone   = "us-east1-c",
    app_id = "t41",
    tags   = ["sap"],
    labels = {
      department = "loans"
    },
    disk_image = [
      {
        size  = 20 #GB
        image = "debian-cloud/debian-11"
      }
    ]
  }
]