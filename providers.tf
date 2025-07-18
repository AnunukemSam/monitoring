terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.64.0" 
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.20.0" 
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.8.0" 
    }
  }

  required_version = ">= 1.3.0"
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

