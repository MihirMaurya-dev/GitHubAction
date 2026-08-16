# Complete Guide to Azure Landing Zones (ALZ)

An **Azure Landing Zone (ALZ)** is a multi-subscription Azure environment that has been pre-configured for scale, security, governance, networking, and identity. It is the foundation of Microsoft's **Cloud Adoption Framework (CAF)**.

---

## 1. The Analogy: Building a City

Imagine you want to build a new city:
- **Without a Landing Zone (Anti-pattern)**: You let developers build houses (workloads/VMs) immediately. Every developer installs their own water pumps, electric generators, and security gates. The city becomes a chaotic, unmanaged mess with security vulnerabilities and duplicate costs.
- **With a Landing Zone (ALZ)**: Before anyone builds a house, the city engineers lay down the main highways, connect centralized water and power grids, zone residential vs. industrial districts, and set up police checkpoints. When developers arrive, they simply plug their houses into the pre-established infrastructure.

An Azure Landing Zone is that pre-established infrastructure.

---

## 2. The 8 Design Areas (Pillars of ALZ)

Microsoft defines 8 design areas that must be configured when setting up an enterprise landing zone. They are divided into **Platform** and **Application** categories:

```
                  ┌────────────────────────────────────────┐
                  │          AZURE LANDING ZONE            │
                  └──────────────────┬─────────────────────┘
                                     │
         ┌───────────────────────────┴───────────────────────────┐
         ▼                                                       ▼
   [PLATFORM AREAS]                                      [APPLICATION AREAS]
   1. Enterprise Agreement & Tenants                      5. Network Topology & Connectivity
   2. Identity & Access Management (RBAC)                  6. Security, Governance & Policies
   3. Management Group & Subscriptions                    7. Business Continuity (BCDR)
   4. Management & Monitoring                             8. Platform Automation & DevOps
```

### 1. Enterprise Agreement (EA) & Azure Active Directory Tenants
- Defines how your billing enrollment is structured.
- Sets up the single Azure AD (Entra ID) tenant that governs authentication across all subscriptions.

### 2. Identity and Access Management (IAM)
- Defines RBAC (Role-Based Access Control) boundaries.
- Encourages using custom roles, groups, and PIM (Privileged Identity Management) instead of assigning high-level admin roles directly to users.

### 3. Management Group & Subscription Organization
- Structures your resource hierarchy. Rather than managing subscriptions individually, they are grouped under Management Groups (MGs) to apply policies and permissions globally.

### 4. Management and Monitoring
- Centralizes logging. Set up a central Log Analytics Workspace (LAW) and Azure Monitor to collect diagnostic logs from all subscriptions automatically.

### 5. Network Topology and Connectivity
- Configures how workloads communicate. Typically structured around a **Hub-and-Spoke** topology or **Azure Virtual WAN**.
- Centralizes firewalls, VPN gateways, and ExpressRoutes in the Hub subscription, while applications sit in isolated Spoke subscriptions.

### 6. Security, Governance, and Compliance
- Uses **Azure Policy** to enforce rules (e.g., "No public IP addresses allowed on VMs" or "All resources must be created in East US").
- Deploys Microsoft Defender for Cloud for vulnerability monitoring.

### 7. Business Continuity and Disaster Recovery (BCDR)
- Defines backup strategies, replication rules, and failover designs for critical infrastructure.

### 8. Platform Automation and DevOps
- Enforces **Infrastructure as Code (IaC)**. Landing zones should be deployed using automated pipelines (GitHub Actions, Azure DevOps) using Terraform or Bicep.

---

## 3. The Core Architectural Layout (Hierarchy)

Below is the standard hierarchy recommended by the Cloud Adoption Framework:

```
                  [ Tenant Root Group ]
                            │
                    [ Top-Level Group ]
                  (e.g., "Contoso Corp")
                            │
      ┌─────────────────────┼─────────────────────┐
      ▼                     ▼                     ▼
 [ Platform ]         [ Workloads ]          [ Sandbox ]
      │                     │                     │
  ┌───┼───┐             ┌───┴───┐             (Unrestricted
  │   │   │             │       │              Testing)
  ▼   ▼   ▼             ▼       ▼
 [Id] [Mg] [Conn]     [Corp] [Online]
```

1. **Platform Management Group**:
   - **Identity (`Id`)**: Subscription for domain controllers, Azure AD Connect, etc.
   - **Management (`Mg`)**: Subscription hosting Log Analytics Workspaces, backup keys, etc.
   - **Connectivity (`Conn`)**: Subscription hosting the main Network Hub, Firewalls, ExpressRoute, and DNS servers.
2. **Workloads Management Group**:
   - **Corp**: Subscriptions for internal application environments (connected to the hub via Peering).
   - **Online**: Subscriptions for public-facing websites (using Application Gateways, Front Doors, etc.).
3. **Sandbox**:
   - Subscriptions where developers can test ideas without strict corporate network routing or billing policies.

---

## 4. Deploying Azure Landing Zones with Terraform

Microsoft maintains an official Enterprise-scale Terraform module to build this entire Management Group hierarchy, assign policies, and set up networking automatically.

Here is a simplified example of how you configure it in Terraform:

```hcl
# main.tf

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Get current client configuration (needed for tenant identity)
data "azurerm_client_config" "current" {}

# Use the official CAF Enterprise Scale Module
module "enterprise_scale" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "6.1.0" # Use the latest version

  root_parent_id = data.azurerm_client_config.current.tenant_id
  root_id        = "contoso"
  root_name      = "Contoso Corporate"

  # Deploy core Landing Zone management groups
  deploy_core_landing_zones = true

  # Configure landing zone management features (Log Analytics, etc.)
  deploy_management_resources    = true
  subscription_id_management     = "YOUR_MANAGEMENT_SUBSCRIPTION_ID"

  # Configure landing zone connectivity features (Hub network, Firewall)
  deploy_connectivity_resources  = true
  subscription_id_connectivity   = "YOUR_CONNECTIVITY_SUBSCRIPTION_ID"
}
```

### Why use Terraform for ALZ?
- **Speed**: Recreates enterprise architecture in minutes.
- **Drift Detection**: Ensures that configuration drift (e.g., someone modifying a security group manually) is caught and corrected.
- **Modularity**: Allows you to customize Management Groups and policies through input variables.
