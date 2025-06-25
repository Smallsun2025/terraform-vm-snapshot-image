provider "azurerm" {
  features {}
}

# 获取现有资源组
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

# 获取现有 VM 的 OS 磁盘
data "azurerm_managed_disk" "os_disk" {
  name                = var.os_disk_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

# 创建快照
resource "azurerm_snapshot" "vm_snapshot" {
  name                = var.snapshot_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  os_type             = "Windows"
  create_option       = "Copy"
  source_uri          = data.azurerm_managed_disk.os_disk.id
}

# 从快照创建 Managed Image
resource "azurerm_image" "custom_image" {
  name                = var.image_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  os_disk {
    os_type  = "Windows"
    os_state = "Generalized"
    snapshot_id = azurerm_snapshot.vm_snapshot.id
  }
}
