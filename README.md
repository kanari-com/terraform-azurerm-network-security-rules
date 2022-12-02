# Azure - Network Security Rules Module

## Introduction

This module will create Network Security Rules, associated to a Network Security Group in Azure.

## Example

This example used a Virtual Machine Module with an associated Azure Application Security Group.

```
module "iaas-public-rules" {
  source                 = "github.com/redoceantechnology/terraform-azurerm-network-security-rules.git?ref=v1.0.0"
  resource_group_name    = module.resource_group.name
  network_security_group = module.virtual_network.subnets["iaas-public"].network_security_group_name
  allow_in_rules = {
    sshgw = {
      priority                                   = 200
      destination_application_security_group_ids = [module.sshgw.application_security_group_id]
      source_address_prefix                      = "Internet"
      destination_port_ranges                    = ["22"]
    }
  }
  allow_out_rules = {
    sshgw_ssh = {
      priority                              = 200
      source_application_security_group_ids = [module.sshgw.application_security_group_id]
      destination_address_prefix            = "*"
      destination_port_ranges               = ["22"]
      protocol                              = "Tcp"
    }
    sshgw_icmp = {
      priority                              = 210
      source_application_security_group_ids = [module.sshgw.application_security_group_id]
      destination_address_prefix            = "*"
      destination_port_ranges               = ["0"]
      protocol                              = "Icmp"
    }
  }
  depends_on = [
    module.resource_group,
    module.virtual_network,
    module.sshgw
  ]
}
```
<br />

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_network_security_rule.AllowAzureCloudCommunicationOutBound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.AllowGetSessionInformationOutBound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.AllowNTPOutBound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.AllowSSHInBound](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.in_dynamic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.out_dynamic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_AllowAzureCloudCommunicationOutBound_enabled"></a> [AllowAzureCloudCommunicationOutBound\_enabled](#input\_AllowAzureCloudCommunicationOutBound\_enabled) | Enable OutBound port 443 to AzureCloud (Priority 110) | `bool` | `false` | no |
| <a name="input_AllowGetSessionInformationOutBound_enabled"></a> [AllowGetSessionInformationOutBound\_enabled](#input\_AllowGetSessionInformationOutBound\_enabled) | Enable OutBound port 80/443 to Internet (Priority 100) | `bool` | `false` | no |
| <a name="input_AllowNTPOutBound_enabled"></a> [AllowNTPOutBound\_enabled](#input\_AllowNTPOutBound\_enabled) | Enable OutBound NTP (123) to Internet (Priority 120) | `bool` | `false` | no |
| <a name="input_AllowSSHInBound_enabled"></a> [AllowSSHInBound\_enabled](#input\_AllowSSHInBound\_enabled) | Enable InBound SSH from Internet (Priority 100) | `bool` | `false` | no |
| <a name="input_allow_in_rules"></a> [allow\_in\_rules](#input\_allow\_in\_rules) | Dynamic InBound rules, check out https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule | `map(any)` | `{}` | no |
| <a name="input_allow_out_rules"></a> [allow\_out\_rules](#input\_allow\_out\_rules) | Dynamic OutBound rules, check out https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule | `map(any)` | `{}` | no |
| <a name="input_network_security_group"></a> [network\_security\_group](#input\_network\_security\_group) | The name of the Network Security Group that we want to attach the rule to | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->