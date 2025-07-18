#resource "azurerm_resource_group" "rg" {
 # name     = var.resource_group_name
#  location = var.location
#}

/* resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Dev"
  }
}
 */

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "helm_release" "prometheus_stack" {
  name       = "monitoring-stack"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "55.5.0"  # You can update this to latest stable
  create_namespace = false  # We've already created it manually

  values = [
    file("${path.module}/helm-values.yaml")
  ]
}
