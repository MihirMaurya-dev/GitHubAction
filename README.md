# 🚀 Terraform GitHub Actions Automations

Welcome to the **Terraform GitHub Actions** repository! This repository is supercharged with industry-standard CI/CD pipelines, security scanners, cost estimation tools, and repository automation. 

## 🏗️ Workflows Included

Here is a breakdown of the automated workflows currently active in this repository:

### 1. Terraform CI & Security Scans (`terraform.yml`)
Triggers on every `push` to `main` and on `pull_request` events. This pipeline acts as a robust gatekeeper for infrastructure changes:
- **🔒 Security Scanners**: 
  - `gitleaks`: Scans for hardcoded secrets/passwords.
  - `trufflehog`: Advanced secret scanning across PR branches.
  - `trivy`: Scans Infrastructure as Code (IaC) for misconfigurations.
- **✅ Terraform Validation**: Runs `terraform init`, `fmt -check`, `validate`, and `tflint`.
- **💰 Infracost Breakdown**: Estimates cloud costs and posts a beautiful comment directly to the Pull Request showing the expected monthly cost changes.
- **📖 Terraform Plan**: Runs `terraform plan` and automatically posts the plan output as a collapsible comment in the Pull Request.
- **🚀 Terraform Apply**: Automatically applies the infrastructure changes when code is merged into the `main` branch.

### 2. Terraform Drift Detection (`drift-detection.yml`)
Triggers automatically on a cron schedule (Every day at 8:00 AM UTC). 
- Checks out the code and runs `terraform plan -detailed-exitcode`.
- **Purpose**: If anyone makes manual changes in the Azure Portal (bypassing the code), this pipeline will detect the drift and fail, automatically emailing the repository owners an alert!

### 3. Pull Request Auto-Labeler (`labeler.yml`)
Triggers whenever a Pull Request is opened or updated. 
- Analyzes the files changed in the PR and automatically applies labels.
- Modifying `.tf` files adds the `terraform` label.
- Modifying workflows adds the `github-actions` label.

## 📂 Repository Structure

```text
.
├── .github/
│   ├── workflows/
│   │   ├── drift-detection.yml    # Daily drift checks
│   │   ├── labeler.yml            # PR Auto-Labeling engine
│   │   └── terraform.yml          # Core Terraform CI/CD
│   └── labeler.yml                # Configuration rules for the labeler
├── env/
│   └── dev/                       # Environment configurations
│       ├── main.tf
│       ├── providers.tf
│       ├── terraform.tfvars       # Default variables to satisfy CI
│       └── variables.tf
├── module/
│   ├── rg/                        # Resource Group module
│   └── vnet/                      # Virtual Network module
└── README.md
```

## 🔐 Secrets Configuration
To ensure these pipelines run successfully, the following secrets must be configured in **Repository Settings > Secrets and variables > Actions**:
- `INFRACOST_API_KEY`: API Key to authenticate with Infracost.
- *(Azure Credentials like `ARM_CLIENT_ID`, `ARM_CLIENT_SECRET`, `ARM_SUBSCRIPTION_ID`, `ARM_TENANT_ID` for Terraform Apply - If applicable).*

## 📊 Monitoring Workflows
You can view and debug all workflow runs from the **Actions** tab at the top of the repository.

---
⭐ Built with Terraform & GitHub Actions.
