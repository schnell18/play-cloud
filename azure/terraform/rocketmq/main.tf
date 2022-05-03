resource "azurerm_linux_virtual_machine_scale_set" "main" {
  name                            = "${var.prefix}-rocketmq"
  resource_group_name             = var.resource_group_name
  location                        = var.location
  sku                             = var.rocketmq_sku
  instances                       = var.rocketmq_initial_instances
  admin_username                  = "adminuser"

  admin_ssh_key {
    username   = "adminuser"
    public_key = var.admin_ssh_pub_key
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7_9-gen2"
    version   = "7.9.2021071901"
  }

  network_interface {
    name    = "example"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.rocketmq_subnet_id
    }
  }

  os_disk {
    storage_account_type = var.storage_type
    caching              = "ReadWrite"
  }

  data_disk {
    storage_account_type = var.storage_type
    caching              = "ReadWrite"
    disk_size_gb         = var.data_disk_size_gb
    lun                  = 10
  }

  # Since these can change via auto-scaling outside of Terraform,
  # let's ignore any changes to the number of instances
  lifecycle {
    ignore_changes = [instances]
  }
}

resource "azurerm_monitor_autoscale_setting" "main" {
  name                = "autoscale-config"
  resource_group_name = var.resource_group_name
  location            = var.location
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.main.id

  profile {
    name = "AutoScale"

    capacity {
      default = var.rocketmq_initial_instances
      minimum = var.rocketmq_min_instances
      maximum = var.rocketmq_max_instances
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.main.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 75
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.main.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 25
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }
}
