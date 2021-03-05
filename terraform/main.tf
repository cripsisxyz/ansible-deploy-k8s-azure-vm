provider "azurerm" {
  version = "~>2.0"
  features {}
}

# Creamos un resource_group con el nombre en base al prefijo y la zona definida en vars
resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-resources"
  location = "${var.location}"
}

