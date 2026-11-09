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

data "azurerm_user_assigned_identity" "jenkins" {
  name                = "jenkins-${var.env}-mi"
  resource_group_name = "managed-identities-${var.env}-rg"
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
