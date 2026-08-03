module "redis" {
  source      = "git@github.com:hmcts/cnp-module-redis?ref=master"
  product     = var.product
  location    = var.location
  env         = var.env
  common_tags = var.common_tags
  name        = "${var.product}-cft-${var.env}"

  redis_version                   = "6"
  business_area                   = "cft"
  private_endpoint_enabled        = true
  public_network_access_enabled   = false
  sku_name                        = var.sku_name
  family                          = var.family
  capacity                        = var.capacity
  maxfragmentationmemory_reserved = var.maxfragmentationmemory_reserved
  maxmemory_delta                 = var.maxmemory_delta
  maxmemory_reserved              = var.maxmemory_reserved
}

# Format: rediss://:[password]@[hostname]:[port]/[db]
resource "azurerm_key_vault_secret" "tax-tribunals-redis-url" {
  name         = "redis-url"
  value        = "rediss://:${urlencode(module.redis.access_key)}@${module.redis.host_name}:${module.redis.redis_port}"
  key_vault_id = module.tt-key-vault.key_vault_id
}

module "managed-redis" {
  source = "git@github.com:hmcts/terraform-module-azure-managed-redis?ref=main"

  product                      = var.product
  component                    = var.component
  env                          = var.env
  location                     = var.location
  common_tags                  = var.common_tags
  existing_resource_group_name = azurerm_resource_group.rg.name

  sku_name          = "Balanced_B0"
  clustering_policy = "EnterpriseCluster"

  public_network_access   = "Disabled"
  create_private_endpoint = true
  subnet_id               = data.azurerm_subnet.core_infra_redis_subnet.id
  private_dns_zone_ids = [
    "/subscriptions/${var.private_dns_subscription_id}/resourceGroups/core-infra-intsvc-rg/providers/Microsoft.Network/privateDnsZones/privatelink.redis.azure.net"
  ]

  access_keys_authentication_enabled = true
}

resource "azurerm_key_vault_secret" "managed-redis-url" {
  name         = "managed-redis-url"
  value        = "rediss://:${urlencode(module.managed-redis.primary_access_key)}@${module.managed-redis.hostname}:${module.managed-redis.port}"
  key_vault_id = module.tt-key-vault.key_vault_id
}

