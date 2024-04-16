# Public ip address
resource "azurerm_public_ip" "pubip" {
  for_each            = toset(var.pub_ip_name)
  name                = each.value
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = var.pub_ip["allocation_method"]
  sku                 = var.pub_ip["sku"]
}

# Network interface card
resource "azurerm_network_interface" "nic" {
  for_each            = var.nics
  name                = each.value.name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = var.vm_details["ip-config-name"]
    subnet_id                     = azurerm_subnet.subnet[each.value.subnet].id
    private_ip_address_allocation = var.vm_details["private-ip-alloc"]
    public_ip_address_id = each.value.name == "web-nic" || each.value.name == "jumphost-nic" ? azurerm_public_ip.pubip[each.value.pub_ip].id : null
  }
}

# Linux virtual machine
resource "azurerm_linux_virtual_machine" "main" {
  for_each            = var.vms
  name                = "${local.resource_name_prefix}-${each.value.name}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = each.value.size
  admin_username      = var.vm_details["admin-username"]
  network_interface_ids = [
    azurerm_network_interface.nic[each.value.nic].id,
  ]

  admin_ssh_key {
    username   = var.vm_details["username"]
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }

  os_disk {
    caching              = var.vm_details["caching"]
    storage_account_type = var.vm_details["storage-acct-type"]
  }

  source_image_reference {
    publisher = var.vm_details["publisher"]
    offer     = var.vm_details["offer"]
    sku       = var.vm_details["sku"]
    version   = var.vm_details["version"]
  }
  custom_data = filebase64("${path.module}/scripts/redhat-webvm-script.sh")
  tags        = local.common_tags
}

# Null Resource and Provisioners
resource "null_resource" "copy_ssh_key_to_jumphost" {
  for_each = { for k, vm in var.vms : k => vm if k == "jumphostvm" }
  connection {
    type = "ssh"
    host = azurerm_linux_virtual_machine.main[each.key].public_ip_address
    user = azurerm_linux_virtual_machine.main[each.key].admin_username
    private_key = file("${path.module}/ssh-keys/terraform-azure.pem")
  }
  provisioner "file" {
    source = "ssh-keys/terraform-azure.pem"
    destination = "/tmp/terraform-azure.pem"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/terraform-azure.pem"
    ]
  }
  depends_on = [
    azurerm_linux_virtual_machine.main
  ]
}



