resource "digitalocean_database_cluster" "postgres" {
  name       = "postgres"
  engine     = "pg"
  version    = "11"
  size       = "db-s-1vcpu-1gb"
  region     = "fra1"
  node_count = 1
}

resource "digitalocean_database_db" "postgres" {
  count      = 7
  cluster_id = digitalocean_database_cluster.postgres.id
  name       = "db${count.index + 1}"

  provisioner "local-exec" {
    command = "say Virtual machine has been created"
  }
}

resource "digitalocean_database_db" "postgres2" {
  for_each = {
    foo = null
    bar = null
  }
  cluster_id = digitalocean_database_cluster.postgres.id
  name       = "db-${each.key}"
}

output "uri" {
  value     = digitalocean_database_cluster.postgres.uri
  sensitive = true
}

output "dbs" {
  value = digitalocean_database_db.postgres[*].name
}

output "dbs2" {
  value = [
    for db in digitalocean_database_db.postgres2 :
    db.name
  ]
}
