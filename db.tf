# module "tt-database" {
#   providers = {
#     azurerm.postgres_network = azurerm.postgres_network
#   }
#   source             = "git@github.com:hmcts/terraform-module-postgresql-flexible?ref=master"
#   env                = var.env

#   product       = var.product
#   component     = var.component
#   business_area = "cft"

#   pgsql_databases = [
#     {
#       name : "application"
#     }
#   ]

#   pgsql_version        = var.db_version
#   admin_user_object_id = var.admin_user_object_id
#   common_tags          = var.common_tags

#   location             = var.location
#   pgsql_storage_mb     = var.db_storage_mb
# }

# # Add DB outputs to keyvault

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

# # resource "azurerm_key_vault_secret" "tt-postgres-host" {
# #   name         = "tt-postgres-host"
# #   value        = module.tt-database.host_name
# #   key_vault_id = module.tt-key-vault.key_vault_id
# # }

# # resource "azurerm_key_vault_secret" "tt-postgres-port" {
# #   name         = "tt-postgres-port"
# #   value        = module.tt-database.postgresql_listen_port
# #   key_vault_id = module.tt-key-vault.key_vault_id
# # }

# # resource "azurerm_key_vault_secret" "tt-postgres-database" {
# #   name         = "tt-postgres-database"
# #   value        = module.tt-database.postgresql_database
# #   key_vault_id = module.tt-key-vault.key_vault_id
# # }