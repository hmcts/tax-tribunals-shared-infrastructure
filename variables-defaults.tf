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

variable "sa_account_kind" {
  type        = string
  default     = "StorageV2"
  description = "Defines the Kind of account. Valid options are Storage, StorageV2 and BlobStorage. Changing this forces a new resource to be created. Defaults to BlobStorage."

  validation {
    condition     = can(regex("^(Storage|StorageV2|BlobStorage)$", var.sa_account_kind))
    error_message = "Invalid input, options: \"Storage\", \"StorageV2\", \"BlobStorage\"."
  }
}

variable "sa_account_tier" {
  type        = string
  default     = "Standard"
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. Changing this forces a new resource to be created. Defaults to Standard."

  validation {
    condition     = can(regex("^(Standard|Premium)$", var.sa_account_tier))
    error_message = "Invalid input, options: \"Standard\", \"Premium\"."
  }
}

variable "sa_account_replication_type" {
  type        = string
  default     = "GRS"
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS and ZRS. Defaults to RAGRS."

  validation {
    condition     = can(regex("^(LRS|GRS|RAGRS|ZRS)$", var.sa_account_replication_type))
    error_message = "Invalid input, options: \"LRS\", \"GRS\", \"RAGRS\", \"ZRS\"."
  }
}

variable "business_area" {
  type    = string
  default = "cft"
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
