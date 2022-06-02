resource "digitalocean_database_cluster" "postgres" {
  name       = "postgres"
  engine     = "pg"
  version    = "11"
  size       = "db-s-1vcpu-1gb"
  region     = "fra1"
  node_count = 1
}

resource "digitalocean_database_db" "postgres" {
  count      = 5
  cluster_id = digitalocean_database_cluster.postgres.id
  name       = "db${count.index + 1}"
}

output "uri" {
  value     = digitalocean_database_cluster.postgres.uri
  sensitive = true
}

output "dbs" {
  value = digitalocean_database_db.postgres[*].name
}
