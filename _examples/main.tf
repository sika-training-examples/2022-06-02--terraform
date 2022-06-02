resource "digitalocean_droplet" "example" {
  for_each = {
    "ondrejsika" = {
      image = local.DEBIAN
    }
  }

  image    = each.value.image
  name     = each.key
  region   = "fra1"
  size     = local.SIZE.SMALL
  ssh_keys = var.config.ssh_keys

  connection {
    type = "ssh"
    user = "root"
    host = self.ipv4_address
  }

  provisioner "remote-exec" {
    inline = [
      "sleep 60",
      "apt-get update",
      "apt-get install -y nginx",
    ]
  }
}

resource "digitalocean_droplet" "cloud-init" {
  image     = local.DEBIAN
  name      = "cloud-init"
  region    = "fra1"
  size      = local.SIZE.SMALL
  ssh_keys  = var.config.ssh_keys
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

output "ipv4" {
  value = [
    for vm in digitalocean_droplet.example :
    vm.ipv4_address
  ]
}

output "cloud-init-ip" {
  value = digitalocean_droplet.cloud-init.ipv4_address
}
