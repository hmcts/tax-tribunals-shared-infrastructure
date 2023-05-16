module "redis" {
  source      = "git@github.com:hmcts/cnp-module-redis?ref=master"
  product     = var.product
  location    = var.location
  env         = var.env
  subnetid    = data.azurerm_subnet.redis.id
  common_tags = var.common_tags
}

data "azurerm_subnet" "core_infra_redis_subnet" {
  name                 = "core-infra-subnet-1-${var.env}"
  virtual_network_name = "core-infra-vnet-${var.env}"
  resource_group_name = "core-infra-${var.env}"
}

# Format: rediss://:[password]@[hostname]:[port]/[db]
resource "azurerm_key_vault_secret" "tax-tribunals-redis-url" {
  name         = "redis-url"
  value        = "rediss://:${urlencode(module.redis.access_key)}@${module.redis.host_name}:${module.redis.redis_port}"
  key_vault_id = module.tt-key-vault.key_vault_id
}
