# Azure Virtual Networks (VNets) Basics

## Landing Zone Pillars

When designing architecture, there are 9 important pillars to discuss:

1. Hierarchy
2. Governance & Compliance
3. IAM (Identity and Access Management)
4. Networking
5. Compute
6. Backup & Disaster Recovery
7. Monitoring
8. Security
9. Cost Optimization

---

## 1. Networking Basics

At its simplest, a **Network** allows devices to communicate with one another. If two computers (e.g., Computer A at `10.0.0.1` and Computer B at `10.0.0.2`) are connected to the same network, they can communicate directly.

## 2. Routers

When you need computers on *different* networks to talk to each other, you use a **Router**. It bridges the gap and forwards traffic from one distinct network to another (e.g., connecting a local network in India to one in the USA).

## 3. IP Addresses & CIDR Notation

*   **IP Address:** Every device connected to a network gets a unique identifier called an IP address (e.g., `10.0.0.1`, `10.0.0.2`).
*   **CIDR Notation (Classless Inter-Domain Routing):** This is how we define the size and range of a network. For example, `10.0.0.0/24`.
    *   The `/24` means the first 24 bits of the address are reserved to identify the network portion.
    *   **Rule of thumb:** The larger the number after the `/`, the smaller the network (fewer IPs). The smaller the number, the larger the network.

| CIDR | Approximate IPs |
| :--- | :--- |
| `/24` | 256 IPs |
| `/16` | 65,536 IPs |
| `/8` | Very large network |

*   **The Entire Internet:** Represented as `0.0.0.0/0`. This encompasses all ~4.29 billion IPv4 addresses.

## 4. Public vs. Private Networks

*   **Public Networks:** These are connected directly to the internet and are accessible publicly (e.g., Google.com).
*   **Private Networks:** These are isolated and used for security and internal communication. They use specific reserved private IP ranges, such as `10.0.0.0/8` or `192.168.0.0/16`.

## 5. Virtual Network (VNet)

**Azure Virtual Network acts like your own private, isolated network in the cloud.** It is the fundamental building block for your private network in Azure.

With a VNet, you can:
* Securely connect Azure resources (like Virtual Machines) to each other, the internet, and your on-premises networks.
* Define your own private IP address spaces using CIDR notation.
* Subdivide that large network into smaller, manageable chunks called **Subnets**.

---

## 6. How to Create a VNet (Azure Portal)

1. **Sign in to the Azure Portal:** Go to [portal.azure.com](https://portal.azure.com).
2. **Search for Virtual Networks:** In the top search bar, type `Virtual Networks` and select it from the services list.
3. **Start Creation:** Click the **+ Create** button.
4. **Basics Tab:**
   * **Subscription:** Choose your Azure subscription.
   * **Resource Group:** Select an existing one or click "Create new" (e.g., `rg-networking-dev`).
   * **Name:** Give your VNet a descriptive name (e.g., `vnet-main-eastus`).
   * **Region:** Select the geographical location for your network (e.g., `East US`).
5. **IP Addresses Tab:**
   * **IPv4 address space:** Azure will usually suggest one (like `10.0.0.0/16`). You can keep this or define your own based on the CIDR notes we discussed earlier.
   * **Subnets:** Click "+ Add subnet" to divide your network. Give it a name (e.g., `snet-frontend`) and an address range (e.g., `10.0.1.0/24`). Click Add.
6. **Security Tab (Optional):** Here you can enable features like a Bastion Host, DDoS Protection, or Azure Firewall. You can leave these disabled/default for a basic VNet.
7. **Tags Tab (Optional):** Add key-value pairs to help organize your resources (e.g., `Environment : Dev`).
8. **Review + Create:** Azure will run a final validation. Once it passes, click **Create**. It will take a few moments to deploy.

---

## 7. How to Create a VNet (Terraform)

**1. Define the Resource Group:**
VNets must live inside a Resource Group.
```hcl
resource "azurerm_resource_group" "example" {
  name     = "rg-networking-dev"
  location = "East US"
}
```

**2. Define the Virtual Network:**
Create the VNet and assign it an address space.
```hcl
resource "azurerm_virtual_network" "example" {
  name                = "vnet-main-eastus"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
}
```

**3. Define a Subnet:**
Carve out a smaller chunk of the VNet's IP range.
```hcl
resource "azurerm_subnet" "example" {
  name                 = "snet-frontend"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}
```

**4. Deploy:**
Run the standard Terraform commands in your terminal:
1. `terraform init`
2. `terraform plan`
3. `terraform apply`
```
