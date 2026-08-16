# Terraform Backend with Azure (`azurerm`): Ultimate Interview Guide

This guide is optimized to help you ace questions about the **Terraform Azure Backend (`azurerm`)** during your DevOps/Cloud Engineering interview.

---

## 1. What is the Azure Backend (`azurerm`)?

The `azurerm` backend stores the Terraform state file (`terraform.tfstate`) as a **Block Blob** inside a **Storage Container** on an **Azure Storage Account**.

### Core Architecture Components:
1. **Resource Group**: A logical container for the storage account.
2. **Storage Account**: The Azure resource that provides storage.
3. **Blob Container**: A folder-like container inside the storage account.
4. **State File (Blob)**: The actual JSON file representing your managed infrastructure.

---

## 2. Key Features of the Azure Backend (Interview Gold)

Interviewers want to see that you understand **security**, **concurrency**, and **high availability** in Azure.

### A. Native State Locking (No Extra Services)
*   **How it works**: Azure Blob Storage supports **native blob leasing**. When a write action (like `terraform apply` or `terraform destroy`) starts, Terraform requests an exclusive lock (lease) on the state blob.
*   **The Interview Answer**: *"In AWS, we need S3 + DynamoDB for locking. In Azure, locking is native. Azure Blob Storage uses a blob lease mechanism. Terraform locks the blob by obtaining a lease, preventing any other writes until the lease is released or expires."*

### B. High Security & RBAC Configuration
*   **The Default (Access Keys)**: Historically, Terraform authenticated using the Storage Account Access Keys. Anyone with access to the keys had full admin access.
*   **The Modern Way (Azure AD / Entra ID Auth)**: By setting `use_azuread_auth = true` inside the backend configuration, Terraform authenticates using Entra ID.
*   **Least Privilege Principle**: You grant your CI/CD runner or developer user the **Storage Blob Data Contributor** RBAC role. They can only read/write state files, without full storage admin access.
*   **Network Isolation**: You can configure Storage Account firewalls to only allow access from specific virtual networks (VNs) or private endpoints, securing your state file from the public internet.

### C. State Versioning & Recovery
*   **Version Control**: By enabling **Blob Versioning** and **Soft Delete** on the Storage Account, you can restore previous versions of your state file if it is corrupted or accidentally deleted.

---

## 3. How to Configure the `azurerm` Backend

### Step 1: Pre-requisites (Create Azure Resources)
You must create the storage resources *before* running `terraform init`.

```bash
# Define variables
RG_NAME="rg-terraform-state"
STORAGE_ACCOUNT_NAME="sttfstate2105"
CONTAINER_NAME="tfstate"
LOCATION="eastus"

# Create resource group
az group create --name $RG_NAME --location $LOCATION

# Create storage account (Standard LRS, secure transfer required, minimum TLS 1.2)
az storage account create \
  --name $STORAGE_ACCOUNT_NAME \
  --resource-group $RG_NAME \
  --location $LOCATION \
  --sku Standard_LRS \
  --min-tls-version TLS1_2 \
  --allow-shared-key-access false # Recommended if using Azure AD Auth

# Create container
az storage container create \
  --name $CONTAINER_NAME \
  --account-name $STORAGE_ACCOUNT_NAME \
  --auth-mode login
```

### Step 2: The Backend Configuration Block

```hcl
terraform {
  required_version = ">= 1.5.0"

  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "sttfstate2105"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"

    use_azuread_auth     = true # Uses Entra ID instead of storage access keys
  }
}
```

---

## 4. Advanced Production Patterns

### Partial Configuration (Dynamic Backend)
In professional environments, you do not hardcode the backend values (like `key` or `storage_account_name`) in your configuration code because it prevents reuse across different environments (e.g., dev, test, prod).

1.  **Define an empty backend block** in your code:
    ```hcl
    terraform {
      backend "azurerm" {}
    }
    ```
2.  **Pass backend details dynamically** during initialization:
    ```bash
    terraform init \
      -backend-config="resource_group_name=rg-terraform-state" \
      -backend-config="storage_account_name=sttfstatedev" \
      -backend-config="container_name=tfstate" \
      -backend-config="key=dev.terraform.tfstate"
    ```
    *Or use a `.tfvars` file for the backend settings:*
    ```bash
    terraform init -backend-config=backend-dev.tfvars
    ```

---

## 5. Critical Azure-Specific Interview Q&A

### Q1: What Azure RBAC role does a developer/pipeline need to run Terraform commands?
*   **Answer**: To read and write the state file using Entra ID authentication, they need the **Storage Blob Data Contributor** role on the storage account or container scope. If they also manage the resources within Azure, they typically need **Contributor** role at the Subscription/Resource Group level.

### Q2: What happens if `terraform apply` crashes and the state lock gets stuck in Azure? How do you fix it?
*   **Answer**:
    1. First, check if there is an active run. If not, you can break the lease.
    2. You can use the Terraform command:
       ```bash
       terraform force-unlock <LOCK_ID>
       ```
    3. Alternatively, in the Azure Portal, you can navigate to the state blob under the Storage Account, select the blob, and click **Break Lease**.

### Q3: How do you isolate environments (Dev, Staging, Prod) in Azure using Terraform State?
*   **Answer**:
    1. **Best Practice (Strong Isolation)**: Use **separate Storage Accounts** in separate Azure subscriptions. This ensures dev and prod state files are entirely isolated and have different IAM controls.
    2. **Medium Isolation**: Use the **same Storage Account** but different **Containers** with distinct RBAC controls.
    3. **Weakest Isolation (Workspaces)**: Use a single Storage Account and Container, letting Terraform manage environment separation via workspace prefixes. (Not recommended for prod/non-prod segregation due to safety risks).

### Q4: Explain how you would recover a corrupted state file in Azure.
*   **Answer**: By enabling **Blob Versioning** on the Storage Account. If a state file becomes corrupted, I can log into the Azure Portal (or use CLI/PowerShell), view the version history of the state blob, and promote the last healthy version to be the current version.

### Q5: Why is setting `use_azuread_auth = true` inside the backend configuration recommended?
*   **Answer**: By default, Terraform uses the storage account access keys. Access keys act as "root" passwords for the entire storage account and cannot be easily scoped or audited. Setting `use_azuread_auth = true` forces Terraform to use Entra ID (RBAC). This allows us to use short-lived credentials, enforce MFA, audit logs, and disable Shared Key access (`allow-shared-key-access = false`) entirely.
