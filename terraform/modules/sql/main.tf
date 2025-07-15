resource "google_sql_database_instance" "default" {
  name             = "eshop-mysql"
  database_version = "MYSQL_8_0"
  region           = var.region

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_network
    }
    backup_configuration {
      enabled = false
    }
  }
  deletion_protection = false
}

resource "google_sql_user" "users" {
  name     = var.db_user
  instance = google_sql_database_instance.default.name
  password = var.db_password
}

resource "google_sql_database" "db" {
  name     = "eshop"
  instance = google_sql_database_instance.default.name
}

output "connection_name" {
  value = google_sql_database_instance.default.connection_name
} 