output "ResourceGroup" {
  value = azurerm_resource_group.myterraformgroup.name
}

output "Azure-FGTPublicIP" {
  value = azurerm_public_ip.FGTPublicIp.ip_address
}

output "Azure-Username" {
  value = var.Azure-adminusername
}

output "Azure-Password" {
  value = var.Azure-adminpassword
}

output "Azure-Internal-Host-IP" {
  value = azurerm_network_interface.Ubuntu-Azure-nic.private_ip_address
}

output "Azure-adminsport" {
  value = var.Azure-adminsport
}

output "Azure-privatecidr" {
  value = var.Azure-privatecidr
}

output "Azure-FGTPrivateIP" {
  value = azurerm_network_interface.fgtport1.private_ip_address
}