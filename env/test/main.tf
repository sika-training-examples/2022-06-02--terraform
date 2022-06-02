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
    environment        = "test"
    cloudflare_zone_id = "dd0036cc8abdf8d12eb9a8cc150d9f08"
    ssh_keys           = var.config.ssh_keys
  }
}
