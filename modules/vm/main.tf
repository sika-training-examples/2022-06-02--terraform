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

variable "name" {
  type = string
}

variable "ssh_keys" {
  type        = list(number)
  description = "List of SSH key IDs"
}

variable "image" {
  type    = string
  default = "debian-10-x64"
}

variable "size" {
  type    = string
  default = "s-1vcpu-1gb"
}

variable "cloudflare_zone_id" {
  type = string
}

resource "digitalocean_droplet" "this" {
  image     = var.image
  name      = var.name
  region    = "fra1"
  size      = var.size
  ssh_keys  = var.ssh_keys
  user_data = <<EOF
#cloud-config
ssh_pwauth: yes
password: asdfasdf2020
chpasswd:
  expire: false
runcmd:
  - |
    apt update
    apt install -y curl sudo git
    curl -fsSL https://ins.oxs.cz/slu-linux-amd64.sh | sudo sh
EOF
}

resource "cloudflare_record" "this" {
  zone_id = var.cloudflare_zone_id
  name    = var.name
  value   = digitalocean_droplet.this.ipv4_address
  type    = "A"
}

output "ip" {
  value = digitalocean_droplet.this.ipv4_address
}

output "domain" {
  value = cloudflare_record.this.hostname
}
