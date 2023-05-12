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
