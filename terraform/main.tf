terraform {
  required_version = ">= 1.5.0"

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

resource "random_pet" "greeting" {
  length = 2
}

resource "local_file" "greeting" {
  filename = "${path.module}/output/greeting.txt"
  content  = "  ${var.hello_there} ${var.engineer_name}! Your random pet name is: ${random_pet.greeting.id}\n"
}
