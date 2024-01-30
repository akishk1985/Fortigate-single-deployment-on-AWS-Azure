// FGT Network Interface port1
resource "azurerm_network_interface" "fgtport1" {
  depends_on = [
    azurerm_subnet.publicsubnet,
    azurerm_public_ip.FGTPublicIp,
  ]
  name                = "fgtport1"
  location            = var.location
  resource_group_name = azurerm_resource_group.myterraformgroup.name

  ip_configuration {
    name                          = "Untrusted"
    subnet_id                     = azurerm_subnet.publicsubnet.id
    private_ip_address_allocation = "Dynamic"
    primary                       = true
    public_ip_address_id          = azurerm_public_ip.FGTPublicIp.id
  }

  tags = {
    environment = "Terraform Single FortiGate"
  }
}

resource "azurerm_network_interface" "fgtport2" {
  depends_on = [
    azurerm_subnet.privatesubnet,
  ]
  name                 = "fgtport2"
  location             = var.location
  resource_group_name  = azurerm_resource_group.myterraformgroup.name
  enable_ip_forwarding = true

  ip_configuration {
    name                          = "Teusted"
    subnet_id                     = azurerm_subnet.privatesubnet.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment = "Terraform Single FortiGate"
  }
}


# Connect the security group to the network interfaces
resource "azurerm_network_interface_security_group_association" "port1nsg" {
  depends_on = [
    azurerm_network_interface.fgtport1,
    azurerm_network_security_group.publicnetworknsg,
  ]
  network_interface_id      = azurerm_network_interface.fgtport1.id
  network_security_group_id = azurerm_network_security_group.publicnetworknsg.id
}

resource "azurerm_network_interface_security_group_association" "port2nsg" {
  depends_on = [
    azurerm_network_interface.fgtport2,
    azurerm_network_security_group.privatenetworknsg,
  ]
  network_interface_id      = azurerm_network_interface.fgtport2.id
  network_security_group_id = azurerm_network_security_group.privatenetworknsg.id
}

resource "azurerm_virtual_machine" "fgtvm" {
  depends_on = [
    azurerm_network_interface.fgtport1,
    azurerm_network_interface.fgtport2,
    azurerm_storage_account.fgtstorageaccount,
    azurerm_network_interface_security_group_association.port1nsg,
    azurerm_network_interface_security_group_association.port2nsg
  ]
  zones                        = [1]
  count                        = var.custom ? 0 : 1
  name                         = "fgtvm"
  location                     = var.location
  resource_group_name          = azurerm_resource_group.myterraformgroup.name
  network_interface_ids        = [azurerm_network_interface.fgtport1.id, azurerm_network_interface.fgtport2.id, ]
  primary_network_interface_id = azurerm_network_interface.fgtport1.id
  vm_size                      = var.size

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = var.publisher
    offer     = var.fgtoffer
    sku       = var.license_type == "byol" ? var.fgtsku["byol"] : var.fgtsku["payg"]
    version   = var.fgtversion
  }

  plan {
    name      = var.license_type == "byol" ? var.fgtsku["byol"] : var.fgtsku["payg"]
    publisher = var.publisher
    product   = var.fgtoffer
  }

  storage_os_disk {
    name              = "osDisk"
    caching           = "ReadWrite"
    managed_disk_type = "Standard_LRS"
    create_option     = "FromImage"
  }

  # Log data disks
  storage_data_disk {
    name              = "fgtvmdatadisk"
    managed_disk_type = "Standard_LRS"
    create_option     = "Empty"
    lun               = 0
    disk_size_gb      = "30"
  }

  os_profile {
    computer_name  = "fgtvm"
    admin_username = var.Azure-adminusername
    admin_password = var.Azure-adminpassword
    custom_data = templatefile("${var.bootstrap-fgtvm}", {
      type          = var.license_type
      license_file  = var.license
      adminsport    = var.Azure-adminsport
      adminusername = var.Azure-adminusername
      adminpassword = var.Azure-adminpassword
    })

  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  boot_diagnostics {
    enabled     = true
    storage_uri = azurerm_storage_account.fgtstorageaccount.primary_blob_endpoint
  }

  tags = {
    environment = "Terraform Single FortiGate"
  }
}
