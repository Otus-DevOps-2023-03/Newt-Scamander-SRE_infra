terraform {
  required_version = ">=1.4.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.90.0"
    }
    # google = {
    #   source = "hashicorp/google"
    #   version = "4.64.0"
    # }
    # kubernetes = {
    #   source = "hashicorp/kubernetes"
    #   version = "2.20.0"
    # }
    # azurerm = {
    #   source = "hashicorp/azurerm"
    #   version = "3.56.0"
    # }
    #   github = {
    #   source = "integrations/github"
    #   version = "5.25.0"
    # }
    # aws = {
    #   source = "hashicorp/aws"
    #   version = "4.67.0"
    # }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
    # dns = {
    #   source  = "hashicorp/dns"
    #   version = "3.3.2"
    # }
    # random = {
    #   source  = "hashicorp/random"
    #   version = "3.5.1"
    # }
    # tls = {
    #   source  = "hashicorp/tls"
    #   version = "4.0.4"
    # }
    # hetznercloud = {
    #   source = "hetznercloud/hcloud"
    #   version = "1.38.2"
    # }

  }
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

######
resource "time_static" "example" {}

resource "yandex_compute_instance" "app" {
  count  = var.instance_count
  name   = "${count.index + 1}-reddit-tmp-${formatdate("YYYY-MM-DD-HH-mm", timestamp())}"
  labels = var.initial_labels

  ######
  resources {
    cores         = 2
    core_fraction = 20
    memory        = 4
  }

  boot_disk {
    initialize_params {
      # Set the IMAGE id of "golden image", created before
      image_id = var.image_id
    }
  }

  network_interface {
    # Set the subnet id in your zone (default: ru-central1-a)
    subnet_id = var.subnet_id
    nat       = true

  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
  ########

  connection {
    type  = "ssh"
    host  = self.network_interface.0.nat_ip_address #Be attention - self use!
    user  = "ubuntu"
    agent = true # <true> when private key doesn't store at ~/.ssh/ and use keepass (for example). <false> - If you should set private key
    #private_key = file("~/.ssh/ya-cloud-otus-key")
  }

  # provisioner "file" {
  #   source      = "files/puma.service"
  #   destination = "/tmp/puma.service"
  # }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}




# resource "yandex_vpc_network" "terraform-deploy-net" {
#   name = "terraform_net-cloud"
# }

# resource "yandex_vpc_subnet" "terraform_subnet" {
#   name = "terraform_subnet-cloud"
#   zone = var.zone
#   network_id = yandex_vpc_network.terraform-deploy-net.id
#   v4_cidr_blocks = [ "192.168.122.0/24" ]
# }




# provider "github" {
#   # Configuration options
# }


# provider "dns" {
#   # Configuration options
# }


# provider "random" {
#   # Configuration options
# }


# provider "tls" {
#   # Configuration options
# }


# provider "hetznercloud" {
#   # Configuration options
# }

# provider "google" {
#   # Configuration options
# }

# provider "azurerm" {
#   # Configuration options
# }
# provider "aws" {
#   # Configuration options
# }
# provider "kubernetes" {
#   # Configuration options
# }
provider "time" {
  # Configuration options
}
