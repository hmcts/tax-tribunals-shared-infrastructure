terraform {
  backend "azurerm" {}

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "< 6.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  alias                           = "postgres_network"
  subscription_id                 = var.aks_subscription_id
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.product}-${var.env}"
  location = var.location
  tags     = var.common_tags
}

provider "azurerm" {
  alias           = "mgmt"
  subscription_id = var.mgmt_subscription_id
  features {}
}

provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  alias                           = "aks"
  subscription_id                 = var.aks_subscription_id
}

provider "azurerm" {
  features {}
  alias                           = "aks_preview"
  subscription_id                 = var.env == "aat" ? "8b6ea922-0862-443e-af15-6056e1c9b9a4" : var.aks_subscription_id
  resource_provider_registrations = "none"
}

provider "azurerm" {
  features {}
  alias                           = "aks_perftest_mgmt"
  subscription_id                 = var.env == "perftest" ? "7a4e3bd5-ae3a-4d0c-b441-2188fee3ff1c" : var.aks_subscription_id
  resource_provider_registrations = "none"
}
