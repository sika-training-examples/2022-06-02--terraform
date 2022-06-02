resource "digitalocean_droplet" "example" {
  for_each = {
    "ondrejsika" = {
      image = "debian-10-x64"
    }
    "ondrejsika2" = {
      image = "ubuntu-22-04-x64"
    }
  }

  image  = each.value.image
  name   = each.key
  region = "fra1"
  size   = "s-1vcpu-1gb"
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
