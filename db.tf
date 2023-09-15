module "tt-database" {
  providers = {
    azurerm.postgres_network = azurerm.postgres_network
  }
  source = "git@github.com:hmcts/terraform-module-postgresql-flexible?ref=master"
  env    = var.env

  product       = var.product
  component     = var.component
  business_area = "cft"

  pgsql_databases = [
    {
      name : "taxtribunals"
    }
  ]

  pgsql_version        = var.db_version
  admin_user_object_id = var.jenkins_AAD_objectId
  common_tags          = var.common_tags

  location         = var.location
  pgsql_storage_mb = var.db_storage_mb
}

# Add DB outputs to keyvault

resource "azurerm_key_vault_secret" "tt-fqdn" {
  name         = "tt-fqdn"
  value        = module.tt-database.fqdn
  key_vault_id = module.tt-key-vault.key_vault_id
}

resource "azurerm_key_vault_secret" "tt-instance-id" {
  name         = "tt-instance-id"
  value        = module.tt-database.instance_id
  key_vault_id = module.tt-key-vault.key_vault_id
}

resource "azurerm_key_vault_secret" "tt-password" {
  name         = "tt-password"
  value        = module.tt-database.password
  key_vault_id = module.tt-key-vault.key_vault_id
}

resource "azurerm_key_vault_secret" "tt-username" {
  name         = "tt-username"
  value        = module.tt-database.username
  key_vault_id = module.tt-key-vault.key_vault_id
}


# resource "azurerm_key_vault_secret" "tt-postgres-user" {
#   name         = "tt-postgres-user"
#   value        = module.tt-database.username
#   key_vault_id = module.tt-key-vault.key_vault_id
# }

# resource "azurerm_key_vault_secret" "tt-postgres-password" {
#   name         = "tt-postgres-password"
#   value        = module.tt-database.password
#   key_vault_id = module.tt-key-vault.key_vault_id
# }

# resource "azurerm_key_vault_secret" "tt-postgres-host" {
#   name         = "tt-postgres-host"
#   value        = module.tt-database.host_name
#   key_vault_id = module.tt-key-vault.key_vault_id
# }

# resource "azurerm_key_vault_secret" "tt-postgres-port" {
#   name         = "tt-postgres-port"
#   value        = module.tt-database.postgresql_listen_port
#   key_vault_id = module.tt-key-vault.key_vault_id
# }

# resource "azurerm_key_vault_secret" "tt-postgres-database" {
#   name         = "tt-postgres-database"
#   value        = module.tt-database.postgresql_database
#   key_vault_id = module.tt-key-vault.key_vault_id
# }
