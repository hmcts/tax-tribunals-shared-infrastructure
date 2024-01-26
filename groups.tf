resource "azurerm_resource_group_template_deployment" "action-group-db" {
  template_content    = data.template_file.actiongrouptemplate.rendered
  name                = var.short_name
  resource_group_name = var.resource_group_name_db
  deployment_mode     = "Incremental"

  parameters_content = jsonencode({
    location             = { value = var.location }
    actionGroupName      = { value = var.action_group_name }
    shortName            = { value = var.short_name }
    emailReceiverName    = { value = var.email_receiver_name }
    emailReceiverAddress = { value = var.email_receiver_address }
  })
}

resource "azurerm_resource_group_template_deployment" "action-group-kv" {
  template_content    = data.template_file.actiongrouptemplate.rendered
  name                = var.short_name
  resource_group_name = var.resource_group_name_kv
  deployment_mode     = "Incremental"

  parameters_content = jsonencode({
    location             = { value = var.location }
    actionGroupName      = { value = var.action_group_name }
    shortName            = { value = var.short_name }
    emailReceiverName    = { value = var.email_receiver_name }
    emailReceiverAddress = { value = var.email_receiver_address }
  })
}

resource "azurerm_resource_group_template_deployment" "action-group-storage" {
  template_content    = data.template_file.actiongrouptemplate.rendered
  name                = var.short_name
  resource_group_name = var.resource_group_name_storage
  deployment_mode     = "Incremental"

  parameters_content = jsonencode({
    location             = { value = var.location }
    actionGroupName      = { value = var.action_group_name }
    shortName            = { value = var.short_name }
    emailReceiverName    = { value = var.email_receiver_name }
    emailReceiverAddress = { value = var.email_receiver_address }
  })
}

output "action_group_name" {
  value = var.action_group_name
}