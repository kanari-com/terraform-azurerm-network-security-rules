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

<!--- BEGIN_TF_DOCS --->

<!--- END_TF_DOCS --->