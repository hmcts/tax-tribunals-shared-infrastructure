resource "azurerm_storage_account" "filestore_storage_account" {
  name                     = "tax-tribunals-filestore-${var.deploy_environment}"
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = var.location
  account_tier             = element(split("_", var.storage_account_type), 0)
  account_replication_type = element(split("_", var.storage_account_type), 1)

  tags = merge(
    map(
      "Name", format("tt_filestore_storage_account")
    )
  )

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_storage_account" "session_storage_account" {
  name                     = "tax-tribunals-sessions-${var.deploy_environment}"
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = var.location
  account_tier             = element(split("_", var.storage_account_type), 0)
  account_replication_type = element(split("_", var.storage_account_type), 1)

  tags = merge(
    map(
      "Name", format("tt_sessions_storage_account")
    )
  )

  lifecycle {
    prevent_destroy = true
  }
}
