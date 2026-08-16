data "azurerm_resource_group" "rg" {
  name = "rgs"
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.vms
  location                        = data.azurerm_resource_group.rg.location
  resource_group_name             = data.azurerm_resource_group.rg.name
  size                            = "Standard_B1s"
  admin_username                  = "adminuser"
  admin_password                  = "Password123!"
  disable_password_authentication = false
  network_interface_ids = [
    var.nic_id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
