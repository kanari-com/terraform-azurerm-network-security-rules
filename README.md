# Azure - Network Security Rules Module

## Introduction

This module will create Network Security Rules, associated to a Network Security Group in Azure.

## Example

This example used a Virtual Machine Module with an associated Azure Application Security Group.

```
module "iaas-public-rules" {
  source                 = "github.com/github.com/redoceantechnology/terraform-azurerm-network-security-rules.git?ref=v1.0.0"
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

<!--- BEGIN_TF_DOCS --->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| AllowAzureCloudCommunicationOutBound\_enabled | Enable OutBound port 443 to AzureCloud (Priority 110) | `bool` | `false` | no |
| AllowGetSessionInformationOutBound\_enabled | Enable OutBound port 80/443 to Internet (Priority 100) | `bool` | `false` | no |
| AllowNTPOutBound\_enabled | Enable OutBound NTP (123) to Internet (Priority 120) | `bool` | `false` | no |
| AllowSSHInBound\_enabled | Enable InBound SSH from Internet (Priority 100) | `bool` | `false` | no |
| allow\_in\_rules | Dynamic InBound rules, check out https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule | `map(any)` | `{}` | no |
| allow\_out\_rules | Dynamic OutBound rules, check out https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule | `map(any)` | `{}` | no |
| network\_security\_group | The name of the Network Security Group that we want to attach the rule to | `string` | n/a | yes |
| resource\_group\_name | Resource group name | `string` | n/a | yes |

## Outputs

No output.

<!--- END_TF_DOCS --->