# Storage account (sa)

**Azure Storage Accounts** contain all Azure Storage data objects (Blobs, Files, Queues, and Tables).
This document focuses on the design of the **storage account itself**, rather than the content of each data object.

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

* How the data arrives
If Azure services or applications write data into the account:

  * Use Private Endpoints to avoid public traffic
  * Ensure safe transfer inside your private network

If accepting data from external sources:

  * Restrict allowed IP ranges
  * Enforce authentication mechanisms
  * Do not allow open access to the storage account

For organizations using cloud proxy services such as **Zscaler** or **Cisco Umbrella**, multiple organizations may share the same public IP.
Therefore, in addition to IP filtering, also consider:

  * Azure AD authentication
  * Managed Identity
  * SAS Tokens
  * Other layered authentication mechanisms

* Who writes the data, and who reads it
Separate permissions for:

  * Writers
  * Readers
  * Administrators

Assign only the minimal required roles (Storage Blob Data Contributor, Storage Blob Data Reader, etc.) to teams or individuals.

* Which application or service writes the data

Clarify which identity and which network path each application or service should use when writing.
| Data Object       | Use Cases                          | Characteristics                                      |
| ----------------- | ---------------------------------- | ---------------------------------------------------- |
| **Blob Storage**  | Images, videos, log files, backups | Unstructured data                                    |
| **File Storage**  | File sharing                       | SMB protocol, mountable from VMs                     |
| **Queue Storage** | Message queues, async workflows    | Decoupled communication between applications         |
| **Table Storage** | NoSQL, log data                    | Lightweight key-value store (simpler than Cosmos DB) |


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
