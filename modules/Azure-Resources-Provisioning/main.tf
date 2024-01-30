// Resource Group

resource "azurerm_resource_group" "myterraformgroup" {
  name     = var.Azure-ResourceGroup
  location = var.location

  tags = {
    environment = "Terraform Single FortiGate"
  }
}