####################
# Development
####################
#Common
env                      = "dev"
location                 = "japaneast"

#Vnet
vnet_address_space       = ["10.0.0.0/20"]

#Subnet
subnet_definitions = {
  cae = { address_prefixes   = "10.0.1.0/24",
          delegation_name    = "containerapp_delegation",
          delegation_service = "Microsoft.App/environments",
          delegation_actions = [
            "Microsoft.Network/virtualNetworks/subnets/action"
          ]
  }
  vm  = { address_prefixes   = "10.0.2.0/24" }
  pep = { address_prefixes   = "10.0.3.0/24" }
}