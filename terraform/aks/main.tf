data "azurerm_resource_group" "rg" {
  name     = "${var.rg}"
}

data "azurerm_container_registry" "acr" {
  name                = "${var.acr}"
  resource_group_name = data.azurerm_resource_group.rg.name
}


# Create the AKS cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-cluster"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  dns_prefix          = "${var.prefix}-cluster"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_A2_v2"
  }

  # Use the System-Assigned Managed Identity
  identity {
    type = "SystemAssigned"
  }

   tags = {
    Environment = "dev"
  }

  api_server_access_profile{
    authorized_ip_ranges = ["112.199.254.90/32"]
  }

  sku_tier = "Free"

}

#Assign the AcrPull role to the AKS cluster's managed identity
resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = data.azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  
  depends_on = [
    azurerm_kubernetes_cluster.aks
  ]
}
