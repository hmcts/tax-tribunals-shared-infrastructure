module "tt_database_pitr" {
  count = local.postgres_pitr_enabled ? 1 : 0

  providers = {
    azurerm.postgres_network = azurerm.postgres_network
  }
  source = "git@github.com:hmcts/terraform-module-postgresql-flexible?ref=master"

  env           = var.env
  product       = var.product
  component     = var.component
  business_area = "cft"
  name          = var.postgres_pitr.name

  resource_group_name      = module.tt-database.resource_group_name
  manage_reader_role_on_rg = false

  create_mode      = "PointInTimeRestore"
  restore_time     = var.postgres_pitr.restore_time
  source_server_id = module.tt-database.instance_id

  pgsql_databases = []
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

import {
  for_each = {
    for name, id in local.postgres_pitr_admin_import_ids : name => id
    if name == "DTS Platform Operations PostgreSQL Admin Access"
  }
  to = module.tt_database_pitr[0].azurerm_postgresql_flexible_server_active_directory_administrator.pgsql_adadmin
  id = each.value.id
}

import {
  for_each = {
    for name, id in local.postgres_pitr_admin_import_ids : name => id
    if name == "jenkins-${var.env}-mi"
  }
  to = module.tt_database_pitr[0].azurerm_postgresql_flexible_server_active_directory_administrator.pgsql_additional_principal_admin[each.value.object_id]
  id = each.value.id
}

import {
  for_each = {
    for name, id in local.postgres_pitr_admin_import_ids : name => id
    if name == "jenkins-cftptl-intsvc-mi"
  }
  to = module.tt_database_pitr[0].azurerm_postgresql_flexible_server_active_directory_administrator.pgsql_principal_admin[0]
  id = each.value.id
}
