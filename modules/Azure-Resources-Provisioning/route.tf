resource "azurerm_route_table" "internal" {
  name                = "InternalRouteTable1"
  location            = var.location
  resource_group_name = azurerm_resource_group.myterraformgroup.name
}

resource "azurerm_route" "default" {
  depends_on             = [azurerm_network_interface.fgtport2]
  name                   = "default"
  resource_group_name    = azurerm_resource_group.myterraformgroup.name
  route_table_name       = azurerm_route_table.internal.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_network_interface.fgtport2.private_ip_address
}

resource "azurerm_subnet_route_table_association" "internalassociate" {
    depends_on             = [
      azurerm_subnet.privatesubnet,
      azurerm_route_table.internal,
      ]
  subnet_id      = azurerm_subnet.privatesubnet.id
  route_table_id = azurerm_route_table.internal.id
}
