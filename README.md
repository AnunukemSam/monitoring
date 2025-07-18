**AKS Monitoring Setup with Prometheus and Grafana (Task 4) - Full Action Plan**

---

## 🚀 Objective

Set up a monitoring and logging platform on an AKS (Azure Kubernetes Service) cluster using **Prometheus** and **Grafana**, and visualize key metrics such as **CPU**, **Memory**, and **Storage** for each Kubernetes pod.

---

## 📓 Table of Contents

1. [Project Overview](#project-overview)
2. [Architecture Diagram](#architecture-diagram)
3. [Tools & Technologies](#tools--technologies)
4. [Manual AKS Cluster Setup](#manual-aks-cluster-setup)
5. [Terraform-Based Monitoring Automation](#terraform-based-monitoring-automation)
6. [How to Use This Project](#how-to-use-this-project)
7. [Screenshots](#screenshots)
8. [Project Structure](#project-structure)
9. [Known Issues & Troubleshooting](#known-issues--troubleshooting)
10. [Credits](#credits)

---

## 📄 Project Overview

This project demonstrates how to deploy a **complete observability stack** into an AKS cluster using a hybrid approach:

* AKS provisioned manually via Azure CLI
* Terraform handles all monitoring infrastructure (namespace, Prometheus, Grafana)

The project focuses on automating the deployment of `kube-prometheus-stack` via Helm using Terraform, while ensuring best practices like isolation (`monitoring` namespace) and persistent volumes.

---

## 🛠️ Architecture Diagram

```
+--------------------------+
|     AKS Cluster (Manual) |
|--------------------------|
|  Namespace: monitoring   |
| + Prometheus             |
| + Grafana                |
| + Node Exporter          |
| + Kube-State-Metrics     |
+--------------------------+
          |
          v
+--------------------------+
|  Grafana Dashboards      |
|  (CPU, Memory, Storage)  |
+--------------------------+
```

---

## 📈 Tools & Technologies

* Azure CLI
* AKS (Azure Kubernetes Service)
* Helm
* Terraform (v1.3+)
* Kubernetes Provider
* Helm Provider
* Prometheus
* Grafana

---

## 🌐 Manual AKS Cluster Setup

```bash
az group create --name aks-rg --location westeurope

az aks create \
  --resource-group aks-rg \
  --name aks-cluster \
  --node-count 2 \
  --node-vm-size Standard_B2s \
  --generate-ssh-keys

az aks get-credentials --resource-group aks-rg --name aks-cluster
kubectl get nodes
```

---

## ⚖️ Terraform-Based Monitoring Automation

### Step-by-Step:

1. Clone this repo
2. Navigate to the project folder
3. Run:

```bash
terraform init
terraform plan
terraform apply
```

Terraform will:

* Create `monitoring` namespace
* Deploy Prometheus + Grafana using `helm_release`
* Persist Grafana dashboards & Prometheus data

### Providers Used:

* `kubernetes` (via \~/.kube/config)
* `helm` (also uses \~/.kube/config)

---

## 🔄 How to Use This Project

### Port-Forward to Access Grafana

```bash
kubectl port-forward svc/monitoring-stack-grafana 3000:80 -n monitoring
```

Visit: [http://localhost:3000](http://localhost:3000)

### Login Credentials

* Username: `admin`
* Password:

```bash
kubectl get secret --namespace monitoring monitoring-stack-grafana -o jsonpath="{.data.admin-password}" | base64 --decode
```

### Import Dashboards

* Dashboard IDs:

  * 315 (Kubernetes Cluster Monitoring)
  * 1860 (Node Exporter Full)
  * 8588 (Pods Overview)

---

## 📸 Screenshots

(Add images to the `screenshots/` folder and reference them here)

* Pod CPU/Memory/Storage usage
* Node metrics
* Cluster overview

---

## 📁 Project Structure

```
question_4/
├── main.tf
├── providers.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
├── helm-values.yaml
├── screenshots/
└── README.md
```

---

## ❌ Known Issues & Troubleshooting

* Some dashboards may show "No Data" if the cluster is idle
* Ensure your Azure subscription has the ContainerService provider registered:

```bash
az provider register --namespace Microsoft.ContainerService
```

* Avoid preview API versions with `azurerm` — use a stable provider version like `3.64.0`


# monitoring
