module "tt-key-vault" {
  source                       = "git@github.com:hmcts/cnp-module-key-vault?ref=master"
  name                         = "${var.product}-cft-${var.env}"
  product                      = var.product
  env                          = var.env
  tenant_id                    = var.tenant_id
  object_id                    = var.jenkins_AAD_objectId
  resource_group_name          = azurerm_resource_group.rg.name
  product_group_name           = var.product_group_name
  common_tags                  = var.common_tags
  create_managed_identity      = true
  jenkins_object_id            = data.azurerm_user_assigned_identity.jenkins.principal_id
  grant_preview_jenkins_access = var.env == "aat"
}

resource "azurerm_key_vault_secret" "tt-fqdn" {
  name         = "tt-fqdn"
  value        = local.postgres_active_fqdn
  key_vault_id = module.tt-key-vault.key_vault_id
}

resource "azurerm_key_vault_secret" "tt-instance-id" {
  name         = "tt-instance-id"
  value        = local.postgres_active_instance_id
  key_vault_id = module.tt-key-vault.key_vault_id
}

resource "azurerm_key_vault_secret" "tt-password" {
  name         = "tt-password"
  value        = module.tt-database.password
  key_vault_id = module.tt-key-vault.key_vault_id
}

resource "azurerm_key_vault_secret" "tt-username" {
  name         = "tt-username"
  value        = local.postgres_active_username
  key_vault_id = module.tt-key-vault.key_vault_id
}

resource "azurerm_key_vault_secret" "app-insights-instrumentation-key" {
  name         = "app-insights-instrumentation-key"
  value        = module.application_insights.instrumentation_key
  key_vault_id = module.tt-key-vault.key_vault_id
}

resource "azurerm_key_vault_secret" "app-insights-connection-string" {
  name         = "app-insights-connection-string"
  value        = module.application_insights.connection_string
  key_vault_id = module.tt-key-vault.key_vault_id
}

# Format: rediss://:[password]@[hostname]:[port]/[db]
resource "azurerm_key_vault_secret" "tax-tribunals-redis-url" {
  name         = "redis-url"
  value        = "rediss://:${urlencode(module.redis.access_key)}@${module.redis.host_name}:${module.redis.redis_port}"
  key_vault_id = module.tt-key-vault.key_vault_id
}

resource "azurerm_key_vault_secret" "managed-redis-url" {
  name         = "managed-redis-url"
  value        = "rediss://:${urlencode(module.managed-redis.primary_access_key)}@${module.managed-redis.hostname}:${module.managed-redis.port}"
  key_vault_id = module.tt-key-vault.key_vault_id
}

resource "azurerm_key_vault_secret" "tt_store_storageaccount_id" {
  depends_on   = [module.tt-key-vault]
  name         = "tt-storage-account-id"
  value        = module.storage-account.storageaccount_id
  key_vault_id = module.tt-key-vault.key_vault_id
}

resource "azurerm_key_vault_secret" "tt-storageaccount_primary_access_key" {
  depends_on   = [module.tt-key-vault]
  name         = "tt-storage-account-primary-access-key"
  value        = module.storage-account.storageaccount_primary_access_key
  key_vault_id = module.tt-key-vault.key_vault_id
}

resource "azurerm_key_vault_secret" "tt-storageaccount_secondary_access_key" {
  depends_on   = [module.tt-key-vault]
  name         = "tt-storage-account-secondary-access-key"
  value        = module.storage-account.storageaccount_secondary_access_key
  key_vault_id = module.tt-key-vault.key_vault_id
}

resource "azurerm_key_vault_secret" "tt-storageaccount_primary_connection_string" {
  depends_on   = [module.tt-key-vault]
  name         = "tt-storage-account-primary-connection-string"
  value        = module.storage-account.storageaccount_primary_connection_string
  key_vault_id = module.tt-key-vault.key_vault_id
}

resource "azurerm_key_vault_secret" "tt-storageaccount_secondary_connection_string" {
  depends_on   = [module.tt-key-vault]
  name         = "tt-storage-account-secondary-connection-string"
  value        = module.storage-account.storageaccount_secondary_connection_string
  key_vault_id = module.tt-key-vault.key_vault_id
}
