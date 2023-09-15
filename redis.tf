module "redis" {
  source      = "git@github.com:hmcts/cnp-module-redis?ref=master"
  product     = var.product
  location    = var.location
  env         = var.env
  common_tags = var.common_tags
  name        = "${var.product}-cft-${var.env}"

  redis_version                 = "6"
  business_area                 = "cft"
  private_endpoint_enabled      = true
  public_network_access_enabled = false
}

# Format: rediss://:[password]@[hostname]:[port]/[db]
resource "azurerm_key_vault_secret" "tax-tribunals-redis-url" {
  name         = "redis-url"
  value        = "rediss://:${urlencode(module.redis.access_key)}@${module.redis.host_name}:${module.redis.redis_port}"
  key_vault_id = module.tt-key-vault.key_vault_id
}
