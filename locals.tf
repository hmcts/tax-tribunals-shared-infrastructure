locals {
  mgmt_network_name    = "cft-ptl-vnet"
  mgmt_network_rg_name = "cft-ptl-network-rg"

  aks_env = var.env == "sandbox" ? "sbox" : var.env

  aat_cft_vnet_name           = "cft-aat-vnet"
  aat_cft_vnet_resource_group = "cft-aat-network-rg"

  cft_aks_network_name    = "cft-${local.aks_env}-vnet"
  cft_aks_network_rg_name = "cft-${local.aks_env}-network-rg"

  preview_vnet_name            = "cft-preview-vnet"
  preview_vnet_resource_group  = "cft-preview-network-rg"
  perftest_vnet_name           = "core-infra-vnet-perftest"
  perftest_subnet_name         = "core-infra-subnet-mgmtperftest"
  perftest_vnet_resource_group = "core-infra-perftest"

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

  standard_subnets = [
    data.azurerm_subnet.jenkins_subnet.id,
    data.azurerm_subnet.jenkins_aks_00.id,
    data.azurerm_subnet.jenkins_aks_01.id,
    data.azurerm_subnet.cft_aks_00_subnet.id,
    data.azurerm_subnet.cft_aks_01_subnet.id
  ]

  preview_subnets   = var.env == "aat" ? [data.azurerm_subnet.preview_aks_00_subnet[0].id, data.azurerm_subnet.preview_aks_01_subnet[0].id] : []
  perftest_subnets  = var.env == "perftest" ? [data.azurerm_subnet.perftest_mgmt_subnet[0].id] : []
  all_valid_subnets = concat(local.standard_subnets, local.preview_subnets, local.perftest_subnets)
}
