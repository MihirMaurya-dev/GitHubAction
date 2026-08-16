# Terraform Modules: From Scratch

Welcome to learning Terraform Modules! A module is simply a container for multiple resources that are used together. By placing resources into a module, you can easily reuse them, pass in different variables, and keep your root codebase incredibly clean.

In this guide, we are creating an **Infrastructure Module** that automatically bundles together:
1. A Resource Group
2. A Storage Account
3. A Virtual Network
4. A Subnet

## 1. Directory Structure

To create a module, we make a subdirectory. Here is the structure we will aim for:

```text
3105/
 ├── main.tf                      <-- The Root Module (where you call the module)
 ├── modules/
 │    └── infrastructure/         <-- Our Custom Module
 │         ├── main.tf            <-- Module resources
 │         ├── variables.tf       <-- Module inputs
 │         └── outputs.tf         <-- Module outputs
```

---

## 2. The Custom Module Files

Inside the `modules/infrastructure/` directory, we need three standard files:

### `variables.tf` (The Inputs)
These are the parameters your module accepts when you call it.

```hcl
variable "base_name" {
  type        = string
  description = "Base name used for resources (e.g., mihir-3105)"
}

variable "location" {
  type        = string
  description = "Azure Region for the resources"
  default     = "belgiumcentral"
}

variable "vnet_address_space" {
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_address_prefix" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
}
```

### `main.tf` (The Resources)
Here, we actually define the Resource Group, Storage Account, Virtual Network, and Subnet. Notice how we use `var.base_name` instead of hardcoding names.

```hcl
# 1. Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "${var.base_name}-rg"
  location = var.location
}

# 2. Storage Account
resource "azurerm_storage_account" "storage" {
  name                     = replace("${var.base_name}sa", "-", "") # Storage names can't have hyphens
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# 3. Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.base_name}-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.vnet_address_space
}

# 4. Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "${var.base_name}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address_prefix
}
```

### `outputs.tf` (The Return Values)
Outputs allow you to export data from the module back to the root module.

```hcl
output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}
```

---

## 3. The Root Module

Now, back in your main directory (`3105/main.tf`), you can delete all the hardcoded resources and simply **call your module**. You just provide the provider block and the module block:

```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.73.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Calling the module!
module "my_infrastructure" {
  source    = "./modules/infrastructure"

  # Passing in our variables
  base_name = "mihir-3105"
  location  = "belgiumcentral"
}
```

## Why is this amazing?
If you suddenly need a second environment (like production), you don't need to rewrite all those resources! You just call the module a second time in your root `main.tf`:

```hcl
module "production_infrastructure" {
  source    = "./modules/infrastructure"
  base_name = "prod-app"
  location  = "westeurope"
}
```
