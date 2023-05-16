module "redis" {
  source      = "git@github.com:hmcts/cnp-module-redis?ref=master"
  product     = var.product
  location    = var.location
  env         = var.env
  subnetid    = data.azurerm_subnet.redis.id
  common_tags = var.common_tags
}

data "azurerm_subnet" "redis" {
  name                 = "redis"
  resource_group_name  = "ss-${var.env}-network-rg"
  virtual_network_name = "ss-${var.env}-vnet"
}

# Format: rediss://:[password]@[hostname]:[port]/[db]
resource "azurerm_key_vault_secret" "tax-tribunals-redis-url" {
  name         = "redis-url"
  value        = "rediss://:${urlencode(module.redis.access_key)}@${module.redis.host_name}:${module.redis.redis_port}"
  key_vault_id = module.tt-key-vault.key_vault_id
}
