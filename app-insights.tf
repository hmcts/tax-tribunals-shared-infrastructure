module "application_insights" {
  source = "git@github.com:hmcts/terraform-module-application-insights?ref=main"

  product = var.product
  env     = var.env

  resource_group_name = azurerm_resource_group.rg.name

  common_tags = var.common_tags

  application_type = "web"
}
resource "azurerm_key_vault_secret" "et-ai-instrumentation-key" {
  name         = "app-insights-instrumentation-key"
  value        = module.application_insights.instrumentation_key
  key_vault_id = module.tt-key-vault.key_vault_id
}
resource "azurerm_key_vault_secret" "et-ai-connection-string" {
  name         = "app-insights-connection-string"
  value        = module.application_insights.connection_string
  key_vault_id = module.tt-key-vault.key_vault_id
}