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

```
azure-terraform-examples/
├── modules/ # Reusable components (e.g., network, app service)
│ └── network/ # Example module for Virtual Network
├── env/ # Environment-specific configurations
│ ├── dev/
│ ├── stg/
│ └── prd/
└── README.md
```

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

Maintained by Sazooka

## Update
16/12/2025 : Create storage account modules
07/12/2025 : Create storage account README.md

## Contact
For inquiries, please contact:
- GitHub Issues: https://github.com/Sazooka/azure-terraform-examples/issues

## What you are accepting money for
Donations help cover Azure costs and allow me to continue publishing free infrastructure examples.

# Legal Notice
This project operates on a donation basis only and does not sell goods or services.
Information required under the Act on Specified Commercial Transactions will be provided upon legitimate request.

