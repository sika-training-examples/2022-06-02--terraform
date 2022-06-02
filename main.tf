resource "digitalocean_droplet" "example" {
  image  = "debian-10-x64"
  name   = "ondrejsika"
  region = "fra1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    digitalocean_ssh_key.default.id,
    digitalocean_ssh_key.default-ed25519.id,
    data.digitalocean_ssh_key.paveljirka.id,
  ]
}

output "ipv4" {
  value = digitalocean_droplet.example.ipv4_address
}
