
resource "azurerm_virtual_network" "windows" {
    name = "windows-virtnet"
    address_space = ["10.0.0.0/16"]
    location = "${var.region}"
    resource_group_name = "${azurerm_resource_group.global.name}"
}

resource "azurerm_subnet" "windows" {
    name = "windows-${format("%02d", count.index + 1)}-sn"
    resource_group_name = "${azurerm_resource_group.global.name}"
    virtual_network_name = "${azurerm_virtual_network.windows.name}"
    address_prefix = "10.0.2.0/24"
}

resource "azurerm_network_interface" "windows" {
    count                        = "${var.vm_count}"
    name = "windows-${format("%02d", count.index + 1)}-nic"
    location = "${var.region}"
    resource_group_name = "${azurerm_resource_group.global.name}"

    ip_configuration {
        name = "testconfiguration1"
        subnet_id = "${azurerm_subnet.windows.id}"
        public_ip_address_id          = "${element(azurerm_public_ip.windows.*.id, count.index)}"
        private_ip_address_allocation = "dynamic"
    }
}

resource "azurerm_public_ip" "windows" {
  count                        = "${var.vm_count}"
  domain_name_label            = "${var.dns_prefix}-win-${format("%02d", count.index + 1)}"
  idle_timeout_in_minutes      = 30
  location                     = "${var.region}"
  name                         = "windows-${format("%02d", count.index + 1)}-publicip"
  public_ip_address_allocation = "static"
  resource_group_name          = "${azurerm_resource_group.global.name}"
}

resource "azurerm_storage_container" "windows" {
  container_access_type = "private"
  count                 = "${var.vm_count}"
  name                  = "windows-${format("%02d", count.index + 1)}-storage"
  resource_group_name   = "${azurerm_resource_group.global.name}"
  storage_account_name  = "${azurerm_storage_account.global.name}"
}

resource "azurerm_virtual_machine" "windows" {
    count                        = "${var.vm_count}"
    name = "win-${format("%02d", count.index + 1)}-vm"
    location = "${var.region}"
    resource_group_name = "${azurerm_resource_group.global.name}"
    network_interface_ids = ["${element(azurerm_network_interface.windows.*.id, count.index)}"]
    vm_size = "${var.vm_size}"

    storage_os_disk {
        name = "windows-${format("%02d", count.index + 1)}-osdisk"
        vhd_uri = "${azurerm_storage_account.global.primary_blob_endpoint}${element(azurerm_storage_container.windows.*.id, count.index)}/disk1.vhd"
        caching = "ReadWrite"
        create_option = "FromImage"
        image_uri = "https://${azurerm_storage_account.global.name}.blob.core.windows.net/${azurerm_storage_container.global.name}/${azurerm_storage_blob.global.name}"
        os_type = "windows"
    }

    os_profile {
        computer_name = "${var.dns_prefix}-${format("%02d", count.index + 1)}"
        admin_username = "${var.usernames[count.index]}"
        admin_password = "${var.passwords[count.index]}"
    }

    os_profile_windows_config {
        provision_vm_agent = true
        enable_automatic_upgrades = true
    }

    tags {
        environment = "staging"
    }
}
