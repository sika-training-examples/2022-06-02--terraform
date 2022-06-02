terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

variable "digitalocean_token" {}

provider "digitalocean" {
  token = var.digitalocean_token
}

resource "digitalocean_ssh_key" "default" {
  name       = "ondrejsika"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCslNKgLyoOrGDerz9pA4a4Mc+EquVzX52AkJZz+ecFCYZ4XQjcg2BK1P9xYfWzzl33fHow6pV/C6QC3Fgjw7txUeH7iQ5FjRVIlxiltfYJH4RvvtXcjqjk8uVDhEcw7bINVKVIS856Qn9jPwnHIhJtRJe9emE7YsJRmNSOtggYk/MaV2Ayx+9mcYnA/9SBy45FPHjMlxntoOkKqBThWE7Tjym44UNf44G8fd+kmNYzGw9T5IKpH1E1wMR+32QJBobX6d7k39jJe8lgHdsUYMbeJOFPKgbWlnx9VbkZh+seMSjhroTgniHjUl8wBFgw0YnhJ/90MgJJL4BToxu9PVnH ondrej@ondrejsika.com"
}

resource "digitalocean_ssh_key" "default-ed25519" {
  name       = "ondrejsika-ed25519"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHtI4BsjxWHmRB3EzyQDSX5idgyjD67XL4WmIjz+pcG6 ondrej@sika-mac"
}

resource "digitalocean_droplet" "example" {
  image  = "debian-10-x64"
  name   = "ondrejsika"
  region = "fra1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    digitalocean_ssh_key.default.id,
    digitalocean_ssh_key.default-ed25519.id,
  ]
}

output "ipv4" {
  value = digitalocean_droplet.example.ipv4_address
}
