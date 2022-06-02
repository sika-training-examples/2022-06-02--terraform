resource "digitalocean_droplet" "example" {
  for_each = {
    "ondrejsika" = {
      image = local.DEBIAN
    }
    "ondrejsika2" = {
      image = local.UBUNTU
    }
  }

  image  = each.value.image
  name   = each.key
  region = "fra1"
  size   = local.SIZE.SMALL
  ssh_keys = [
    digitalocean_ssh_key.default.id,
    digitalocean_ssh_key.default-ed25519.id,
    data.digitalocean_ssh_key.paveljirka.id,
  ]
}

output "ipv4" {
  value = [
    for vm in digitalocean_droplet.example :
    vm.ipv4_address
  ]
}
