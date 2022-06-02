variable "cloudflare_zone_id" {}

module "vm--ondrejsika-foo" {
  source = "./modules/vm"
  name   = "ondrejsika-foo"
  ssh_keys = [
    digitalocean_ssh_key.default.id,
  ]
  cloudflare_zone_id = var.cloudflare_zone_id
}

output "ondrejsika-foo" {
  value = {
    ip            = module.vm--ondrejsika-foo.ip
    domain        = module.vm--ondrejsika-foo.domain
    price_hourly  = module.vm--ondrejsika-foo.digitalocean_droplet.price_hourly
    price_monthly = module.vm--ondrejsika-foo.digitalocean_droplet.price_monthly
  }
}
