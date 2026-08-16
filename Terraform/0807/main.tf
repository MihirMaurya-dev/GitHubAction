resource "azurerm_resource_group" "rg1" {
  name     = var.rg
  location = var.l
  tags = {
    env = var.env
  }
}

resource "azurerm_virtual_network" "vnet1" {
  name                = var.vnet
  address_space       = [var.vnet_as]
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  tags = {
    env = var.env
  }
}

resource "azurerm_subnet" "subnet1" {
  name                 = var.subnet
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = [var.subnet_as]
}

resource "azurerm_network_security_group" "nsg1" {
  name                = var.nsg
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  tags = {
    env = var.env
  }
}

resource "azurerm_network_security_rule" "nsg_rule1" {
  name                        = var.nsg_rule
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = var.nsg_rule_port
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg1.name
  network_security_group_name = azurerm_network_security_group.nsg1.name
}
resource "azurerm_subnet_network_security_group_association" "subnet_nsg_assoc1" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}

resource "azurerm_public_ip" "pip1" {
  name                = var.pip
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    env = var.env
  }
}

resource "azurerm_network_interface" "nic1" {
  name                = var.nic
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip1.id
  }
  tags = {
    env = var.env
  }
}

resource "azurerm_linux_virtual_machine" "vm1" {
  name                            = var.vm
  resource_group_name             = azurerm_resource_group.rg1.name
  location                        = azurerm_resource_group.rg1.location
  size                            = var.vm_size
  admin_username                  = var.vm_admin_user
  admin_password                  = var.vm_admin_password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.vm_image_publisher
    offer     = var.vm_image_offer
    sku       = var.vm_image_sku
    version   = "latest"
  }
  tags = {
    env = var.env
  }
}
