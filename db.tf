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
  pgsql_server_configuration = [
    {
      name  = "azure.extensions"
      value = "UUID-OSSP"
    }
  ]

  pgsql_version        = var.db_version
  admin_user_object_id = var.jenkins_AAD_objectId
  common_tags          = var.common_tags

  location         = var.location
  pgsql_storage_mb = var.db_storage_mb
}
