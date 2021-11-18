variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "network_security_group" {
  description = "The name of the Network Security Group that we want to attach the rule to"
  type        = string
}

variable "AllowSSHInBound_enabled" {
  description = "Enable InBound SSH from Internet (Priority 100)"
  type        = bool
  default     = false
}
variable "AllowGetSessionInformationOutBound_enabled" {
  description = "Enable OutBound port 80/443 to Internet (Priority 100)"
  type        = bool
  default     = false
}
variable "AllowAzureCloudCommunicationOutBound_enabled" {
  description = "Enable OutBound port 443 to AzureCloud (Priority 110)"
  type        = bool
  default     = false
}
variable "AllowNTPOutBound_enabled" {
  description = "Enable OutBound NTP (123) to Internet (Priority 120)"
  type        = bool
  default     = false
}
variable "allow_out_rules" {
  description = "Dynamic OutBound rules, check out https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule"
  type        = map(any)
  default     = {}
}
variable "allow_in_rules" {
  description = "Dynamic InBound rules, check out https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule"
  type        = map(any)
  default     = {}
}
