# Creación de red interna para la comunicación de los nodos de k8s
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network

resource "azurerm_virtual_network" "myNet" {
    name                = "kubernetesnet"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.main.location
    resource_group_name = azurerm_resource_group.main.name

}

# Creación de subnet 
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet

resource "azurerm_subnet" "mySubnet" {
    name                   = "terraformsubnet"
    resource_group_name    = azurerm_resource_group.main.name
    virtual_network_name   = azurerm_virtual_network.myNet.name
    address_prefixes       = ["10.0.1.0/24"]

}

# Crear un NIC para master
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface

resource "azurerm_network_interface" "nic_master" {
  name                = "vmnicmaster"  
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

    ip_configuration {
    name                           = "myipconfigurationmaster"
    subnet_id                      = azurerm_subnet.mySubnet.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = "10.0.1.10"
    public_ip_address_id           = azurerm_public_ip.myPublicIp1.id
  }

}

# WORKERS
resource "azurerm_network_interface" "nic_worker_1" {
  name                = "vmnicworker1"  
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

    ip_configuration {
    name                           = "myipconfigurationworker1"
    subnet_id                      = azurerm_subnet.mySubnet.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = "10.0.1.21"
  }

}

resource "azurerm_network_interface" "nic_worker_2" {
  name                = "vmnicworker2"  
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

    ip_configuration {
    name                           = "myipconfigurationworker2"
    subnet_id                      = azurerm_subnet.mySubnet.id 
    private_ip_address_allocation  = "Static"
    private_ip_address             = "10.0.1.22"
  }

}

# IP pública
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip

resource "azurerm_public_ip" "myPublicIp1" {
  name                = "vms2"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

}