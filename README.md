# Azure Terraform Examples

This repository contains **Infrastructure as Code (IaC)** examples with Terraform on **Microsoft Azure**.

## Overview
These examples demonstrate how to deploy and manage Azure resources using Terraform, including:
- Virtual Networks (VNet)
- (More modules will be added later for Container App Service, Container Apps, etc.)

## Project Structure
### `env/`
Each environment (dev, stg, prd) has its own `main.tf`, which calls the shared modules.  
This structure helps to:
- Keep environments isolated  
- Avoid accidental resource overlap  
- Simplify CI/CD pipelines (per environment)

azure-terraform-examples/
├── modules/ # Reusable components (e.g., network, app service)
│ └── network/ # Example module for Virtual Network
├── env/ # Environment-specific configurations
│ ├── dev/
│ ├── stg/
│ └── prd/
└── README.md

Example `env/dev/main.tf`:

```hcl
module "vnet" {
  source = "../../modules/vnet"
  vnet_name = "dev-vnet"
  address_space = ["nn.n.n.n/nn"]
  location = "xxxxxxxx"
}
```

## License

This project is licensed under the MIT License — see the LICENSE
 file for details.

## Author

Maintained by Sazooka — IaC Engineer focusing on Azure & Terraform.
