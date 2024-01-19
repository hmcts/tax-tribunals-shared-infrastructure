# Variables with default values or values specified in an {env}.tfvars file

variable "location" {
  default = "UK South"
}

variable "common_tags" {
  type = map(string)
}

# Database

variable "db_storage_mb" {
  default = "32768"
}

variable "component" {
  default = "service"
}

variable "db_version" {
  default = 14
}

variable "admin_user_object_id" {
  default = "tax_tribunals_postgresql_user"
}

# provided by the Jenkins library, ADO users will need to specify this

variable "aks_subscription_id" {}

# Keyvault

variable "product_group_name" {
  default = "dcd_group_pet_v2"
}
variable "family" {
  default     = "C"
  description = "The SKU family/pricing group to use. Valid values are `C` (for Basic/Standard SKU family) and `P` (for Premium). Use P for higher availability, but beware it costs a lot more."
}

variable "sku_name" {
  default     = "Basic"
  description = "The SKU of Redis to use. Possible values are `Basic`, `Standard` and `Premium`."
}

variable "capacity" {
  default     = "1"
  description = "The size of the Redis cache to deploy. Valid values are 1, 2, 3, 4, 5"
}

# Groups

variable "short_name" {
  default = "tax-tribunals"
}

variable "resource_group_name_db" { # for DB
  default = "tax-tribunals-infrastructure-data-prod"
}

variable "resource_group_name_kv" { # for kv
  default = "tax-tribunals-prod"
}

variable "resource_group_name_storage" { # for storage
  default = "tax-tribunals-prod"
}

variable "action_group_name" {
  default = "tax-tribunals-action-group"
}

variable "email_receiver_name" {
  default = "Tax Tribunals Alerts Receiver"
}

variable "email_receiver_address" {
  default = "william.taylor@hmcts.net"
}
