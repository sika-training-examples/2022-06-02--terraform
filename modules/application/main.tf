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

module "vm--application" {
  source             = "../../modules/vm"
  name               = "${var.config.environment}-application"
  ssh_keys           = var.config.ssh_keys
  cloudflare_zone_id = var.config.cloudflare_zone_id
}

module "vm--db" {
  source             = "../../modules/vm"
  name               = "${var.config.environment}-db"
  ssh_keys           = var.config.ssh_keys
  cloudflare_zone_id = var.config.cloudflare_zone_id
}

output "ips" {
  value = {
    application = module.vm--application.ip
    db          = module.vm--db.ip
  }
}
