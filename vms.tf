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
  value = module.vm--ondrejsika-foo
}
