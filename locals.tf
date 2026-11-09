locals {
  postgres_pitr_enabled = var.postgres_pitr == null ? false : var.env == var.postgres_pitr.env
  postgres_pitr_cutover = local.postgres_pitr_enabled && var.postgres_use_pitr

  postgres_active_fqdn        = local.postgres_pitr_cutover ? module.tt_database_pitr[0].fqdn : module.tt-database.fqdn
  postgres_active_username    = local.postgres_pitr_cutover ? module.tt_database_pitr[0].username : module.tt-database.username
  postgres_active_instance_id = local.postgres_pitr_cutover ? module.tt_database_pitr[0].instance_id : module.tt-database.instance_id

  postgres_pitr_admin_import_ids = local.postgres_pitr_enabled ? {
    for name, object_id in var.postgres_pitr.import_object_ids : name => {
      object_id = object_id
      id = format(
        "/subscriptions/%s/resourceGroups/%s/providers/Microsoft.DBforPostgreSQL/flexibleServers/%s-%s/administrators/%s",
        data.azurerm_client_config.current.subscription_id,
        module.tt-database.resource_group_name,
        var.postgres_pitr.name,
        var.env,
        object_id
      )
    }
  } : {}

}
