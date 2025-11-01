# Terraform Basic Commands
This guide explains the most common Terraform commands with simple examples.  
You can copy and run each command directly from your terminal.

---

## terraform init

**Purpose:**
Initialize a working directory containing Terraform configuration files.  
This command downloads the required provider plugins (like AzureRM) and sets up the backend for state storage.

```bash
terraform init
```
## terraform validate

**Purpose:**
Check whether your .tf configuration files are syntactically valid and internally consistent.

```bash
terraform validate
```

## terraform plan
**Purpose:**
Preview the changes that Terraform will make before applying them.
It compares the current state with the desired configuration and shows a detailed execution plan.

```bash
terraform plan  
```

### Option 1: Save the plan for later (-out)
You can save the generated plan and apply it later without re-calculating changes.
terraform plan -out=planfile.tfplan

Then apply it safely:
terraform apply "planfile.tfplan"
This ensures that the applied plan exactly matches what you reviewed earlier.

### Option 2: Target a specific resource or module (-target)
Useful when you want to plan or apply only a part of the infrastructure (for example, one module or one resource).
terraform plan -target=azurerm_resource_group.example

Example:
If you only want to plan the Resource Group creation:
terraform plan -target=module.resource_group

This is especially handy during step-by-step deployment or troubleshooting specific modules.

### Option 3: Use environment-specific variables (-var-file)
If you manage multiple environments (like dev, staging, prod),
use separate .tfvars files to handle differences in names, regions, etc.

terraform plan -var-file="dev.tfvars"

Example:

terraform plan -var-file="env/dev.tfvars"
terraform plan -var-file="env/prod.tfvars"

This helps you keep your configurations reusable across environments.

### Combine options
You can combine these options for a complete and reproducible plan:
terraform plan -var-file="env/dev.tfvars" -out="dev-plan.tfplan"

Later:
terraform apply "dev-plan.tfplan"