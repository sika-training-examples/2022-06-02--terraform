variable "cloudflare_zone_id" {}


module "env--global" {
  source = "./env/global"
}

locals {
  config = {
    ssh_keys = module.env--global.ssh_keys
  }
}

module "env--dev" {
  source = "./env/dev"
  config = local.config
}

module "env--test" {
  source = "./env/test"
  config = local.config
}

module "env--prod" {
  source = "./env/prod"
  config = local.config
}
