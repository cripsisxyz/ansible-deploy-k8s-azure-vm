# Dfinimos los recursos de máquina virtual para el nodo master
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine

resource "azurerm_linux_virtual_machine" "k8s-master" {
    name                = "k8s-master"
    resource_group_name = azurerm_resource_group.main.name
    location            = azurerm_resource_group.main.location
    size                = var.vm_size_master
    admin_username      = "ansible"
    network_interface_ids = [ azurerm_network_interface.nic_master.id ]
    disable_password_authentication = true

    admin_ssh_key {
        username   = "${var.defadmonuser}"
        public_key = file("~/.ssh/id_rsa.pub")
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    plan {
        name      = "centos-8-stream-free"
        product   = "centos-8-stream-free"
        publisher = "cognosys"
    }

    source_image_reference {
        publisher = "cognosys"
        offer     = "centos-8-stream-free"
        sku       = "centos-8-stream-free"
        version   = "1.2019.0810"
    }

}

resource "azurerm_linux_virtual_machine" "k8s-worker-1" {
    name                = "k8s-worker-1"
    resource_group_name = azurerm_resource_group.main.name
    location            = azurerm_resource_group.main.location
    size                = var.vm_size_worker
    admin_username      = "ansible"
    network_interface_ids = [ azurerm_network_interface.nic_worker_1.id ]
    disable_password_authentication = true

    admin_ssh_key {
        username   = "${var.defadmonuser}"
        public_key = file("~/.ssh/id_rsa.pub")
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    plan {
        name      = "centos-8-stream-free"
        product   = "centos-8-stream-free"
        publisher = "cognosys"
    }

    source_image_reference {
        publisher = "cognosys"
        offer     = "centos-8-stream-free"
        sku       = "centos-8-stream-free"
        version   = "1.2019.0810"
    }

}

resource "azurerm_linux_virtual_machine" "k8s-worker-2" {
    name                = "k8s-worker-2"
    resource_group_name = azurerm_resource_group.main.name
    location            = azurerm_resource_group.main.location
    size                = var.vm_size_worker
    admin_username      = "ansible"
    network_interface_ids = [ azurerm_network_interface.nic_worker_2.id ]
    disable_password_authentication = true

    admin_ssh_key {
        username   = "${var.defadmonuser}"
        public_key = file("~/.ssh/id_rsa.pub")
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    plan {
        name      = "centos-8-stream-free"
        product   = "centos-8-stream-free"
        publisher = "cognosys"
    }

    source_image_reference {
        publisher = "cognosys"
        offer     = "centos-8-stream-free"
        sku       = "centos-8-stream-free"
        version   = "1.2019.0810"
    }

}
