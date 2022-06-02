terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}

variable "config" {}

module "application" {
  source = "../../modules/application"

  config = {
    environment        = "prod"
    cloudflare_zone_id = "3ba5d048f4d88833ae1e2638ad57ee64"
    ssh_keys           = var.config.ssh_keys
  }
}
