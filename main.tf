
resource "azurerm_network_security_rule" "AllowSSHInBound" {
  count                       = var.AllowSSHInBound_enabled ? 1 : 0
  name                        = "AllowSSHInBound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.network_security_group
}


resource "azurerm_network_security_rule" "AllowGetSessionInformationOutBound" {
  count             = var.AllowGetSessionInformationOutBound_enabled ? 1 : 0
  name              = "AllowGetSessionInformationOutBound"
  priority          = 100
  direction         = "Outbound"
  access            = "Allow"
  protocol          = "Tcp"
  source_port_range = "*"
  destination_port_ranges = [
    "80",
    "443"
  ]
  source_address_prefix       = "*"
  destination_address_prefix  = "Internet"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.network_security_group
}

resource "azurerm_network_security_rule" "AllowAzureCloudCommunicationOutBound" {
  count                       = var.AllowAzureCloudCommunicationOutBound_enabled ? 1 : 0
  name                        = "AllowAzureCloudCommunicationOutBound"
  priority                    = 110
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "AzureCloud"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.network_security_group
}

resource "azurerm_network_security_rule" "AllowNTPOutBound" {
  count                       = var.AllowNTPOutBound_enabled ? 1 : 0
  name                        = "AllowNTPOutBound"
  priority                    = 120
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "123"
  source_address_prefix       = "*"
  destination_address_prefix  = "Internet"
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.network_security_group
}


resource "azurerm_network_security_rule" "out_dynamic" {
  for_each                                   = var.allow_out_rules
  name                                       = "allow-${each.key}-out"
  priority                                   = each.value.priority
  direction                                  = "Outbound"
  access                                     = "Allow"
  protocol                                   = lookup(each.value, "protocol", "*")
  source_port_range                          = "*"
  destination_port_range                     = lookup(each.value, "destination_port_range", null)
  destination_port_ranges                    = lookup(each.value, "destination_port_ranges", null)
  source_address_prefix                      = lookup(each.value, "source_address_prefix", null)
  source_address_prefixes                    = lookup(each.value, "source_address_prefixes", null)
  source_application_security_group_ids      = lookup(each.value, "source_application_security_group_ids", null)
  destination_address_prefix                 = lookup(each.value, "destination_address_prefix", null)
  destination_address_prefixes               = lookup(each.value, "destination_address_prefixes", null)
  destination_application_security_group_ids = lookup(each.value, "destination_application_security_group_ids", null)
  resource_group_name                        = var.resource_group_name
  network_security_group_name                = var.network_security_group
}

resource "azurerm_network_security_rule" "in_dynamic" {
  for_each                                   = var.allow_in_rules
  name                                       = "allow-${each.key}-in"
  priority                                   = each.value.priority
  direction                                  = "Inbound"
  access                                     = "Allow"
  protocol                                   = lookup(each.value, "protocol", "*")
  source_port_range                          = "*"
  destination_port_range                     = lookup(each.value, "destination_port_range", null)
  destination_port_ranges                    = lookup(each.value, "destination_port_ranges", null)
  source_address_prefix                      = lookup(each.value, "source_address_prefix", null)
  source_address_prefixes                    = lookup(each.value, "source_address_prefixes", null)
  source_application_security_group_ids      = lookup(each.value, "source_application_security_group_ids", null)
  destination_address_prefix                 = lookup(each.value, "destination_address_prefix", null)
  destination_address_prefixes               = lookup(each.value, "destination_address_prefixes", null)
  destination_application_security_group_ids = lookup(each.value, "destination_application_security_group_ids", null)
  resource_group_name                        = var.resource_group_name
  network_security_group_name                = var.network_security_group
}
