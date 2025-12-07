# Storage account (sa)

Azure Storage Accounts contain all Azure Storage data objects (Blobs, Files, Queues, and Tables).
This document focuses on the design of the storage account itself, rather than the content of each data object.

The actual IaC implementation will follow a cost-optimized minimal configuration, assuming that the first deployment must be inexpensive.
Below are two major perspectives to consider.
These points are often assumed to be “common understanding” in organizations, yet in reality they tend to be vague during design.
Use them as reference.

## 1. What kind of data will be stored?
The type of data placed in the storage account significantly affects requirements such as performance, security, retention, and cost.
* Sensitive or regulated data
If handling personal information, audit logs, or any data requiring strict access control:
  * Create a dedicated Resource Group and dedicated Storage Account
  * Define clear RBAC and operational boundaries
  * Strengthen the security boundary using network configurations such as Private Endpoints and Firewall Rules
> Note: A Resource Group functions well as an operational boundary, but it is weak as a security boundary.
  Network-level security must be combined with RBAC.

* Read/write frequency and performance requirements
  * High-volume workloads (ETL, analytics) may require Premium performance tiers
  * For metadata storage or files related to generative AI workflows, Standard tiers are often sufficient

* Long-term log retention
  * When log data must be kept for years, rarely accessed, or is owned by a different team, it is common to place it in a separate Storage Account. 
  Estimate cost based on:
   * Expected yearly data volume
   * Required retention period
   * Access frequency
  Use the Azure Pricing Calculator for cost estimates. 

## 2. Where does the data come from, and who handles it?
You must identify where the data originates, who writes it, and who reads or manages it.

**Example: Container Apps**
```hcl
```


## 3. 

### Terraform Example
**modules/snet/main.tf:**
```hcl
```hcl

```



**env/dev/dev.tfvars:**
```hcl
```

**env/stg/stg.tfvars:**
```hcl
```

**env/prod/prod.tfvars:**
```hcl
```

**Benefits:**
