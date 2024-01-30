#network interface for internal VM
resource "azurerm_network_interface" "Ubuntu-Azure-nic" {
  depends_on = [ azurerm_subnet.privatesubnet, ]
  name                = "Ubuntu-Azure-nic"
  location            = var.location
  resource_group_name      = azurerm_resource_group.myterraformgroup.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.privatesubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_security_group_association" "Ubuntu-VM" {
  depends_on = [ 
    azurerm_network_interface.Ubuntu-Azure-nic, 
    azurerm_network_security_group.privatenetworknsg, 
    ]
  network_interface_id      = azurerm_network_interface.Ubuntu-Azure-nic.id
  network_security_group_id = azurerm_network_security_group.privatenetworknsg.id
}

resource "azurerm_virtual_machine" "Ubuntu-Azure" {
  depends_on = [ 
    azurerm_network_interface.Ubuntu-Azure-nic,
    azurerm_network_interface_security_group_association.Ubuntu-VM
    ]
  name                  = "Ubuntu-Azure"
  location            = var.location
  resource_group_name      = azurerm_resource_group.myterraformgroup.name
  network_interface_ids = [azurerm_network_interface.Ubuntu-Azure-nic.id]
  vm_size               = "Standard_B1s"
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk2"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "Ubuntu-Azure"
    admin_username = var.Azure-adminusername
    admin_password = var.Azure-adminpassword
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}