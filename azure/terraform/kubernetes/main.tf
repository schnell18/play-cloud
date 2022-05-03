# create a private image registry for containerized app
resource "azurerm_container_registry" "worker" {
  name                = "${var.prefix}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.image_registry_sku
}

resource "azurerm_kubernetes_cluster" "worker" {
  name                = "${var.prefix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.prefix}"

  default_node_pool {
    name           = "system"
    node_count     = 1
    vm_size        = var.k8s_node_sku
    vnet_subnet_id = var.k8s_subnet_id
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "calico"
    load_balancer_sku = "standard"
  }

  identity {
    type = "SystemAssigned"
  }

  addon_profile {
    aci_connector_linux {
      enabled = false
    }

    azure_policy {
      enabled = false
    }

    http_application_routing {
      enabled = false
    }

    oms_agent {
      enabled = false
    }
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "user" {
  name                  = "user"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.worker.id
  vm_size               = var.k8s_node_sku
  node_count            = var.k8s_node_count
  vnet_subnet_id        = var.k8s_subnet_id
}

