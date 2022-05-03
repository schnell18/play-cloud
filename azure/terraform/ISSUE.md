# fail to create MySQL basic tier instance w/ private IP

Get error message like:

	╷
	│ Error: creating Server: (Name "exploremysqldb" / Resource Group "exploreAZDev"): mysql.ServersClient#Create: Failure sending request: StatusCode=0 -- Original Error: Code="FeatureSwitchNotEnabled" Message="Requested feature is not enabled"
	│
	│   with module.mysql.azurerm_mysql_server.mysql,
	│   on mysql/main.tf line 7, in resource "azurerm_mysql_server" "mysql":
	│    7: resource "azurerm_mysql_server" "mysql" {
	│
	╵

with **public_network_access_enabled** set to true.

Solution is set this property to false or upgrade to genenal or memory
optimized tier. Refer to [this issue][1] for more information.

# fail to create virtual network


    ╷
    │ Error: creating/updating Virtual Network: (Name "exploreAZVNet" / Resource Group "exploreAZDev"): network.VirtualNetworksClient#CreateOrUpdate: Failure sending request: StatusCode=0 -- Original Error: Code="ResourceGroupNotFound" Message="Resource group 'exploreAZDev' could not be found."
    │
    │   with module.vnet.azurerm_virtual_network.vnet,
    │   on vnet/main.tf line 17, in resource "azurerm_virtual_network" "vnet":
    │   17: resource "azurerm_virtual_network" "vnet" {
    │
    ╵

# enable terraform debug

To trouble shoot issue, you can enable terraform debug as follows:

    export TF_LOG=trace
    terraform apply

# create linux vm error

Get error like:

	╷
	│ Error: creating Linux Virtual Machine "myadminlinuxstation-vm" (Resource Group "exploreAZDev"): compute.VirtualMachinesClient#CreateOrUpdate: Failure sending request: StatusCode=0 -- Original Error: Code="InvalidParameter" Message="The value myadminlinuxstation provided for the VM size is not valid. The valid sizes in the current region are: Standard_B1ls,Standard_B1ms,Standard_B1s,Standard_B2ms,Standard_B2s,Standard_B4ms,Standard_B8ms,Standard_B12ms,Standard_B16ms,Standard_B20ms,Standard_DS1_v2,Standard_DS2_v2,Standard_DS3_v2,Standard_DS4_v2,Standard_DS5_v2,Standard_DS11-1_v2,Standard_DS11_v2,Standard_DS12-1_v2,Standard_DS12-2_v2,Standard_DS12_v2,Standard_DS13-2_v2,Standard_DS13-4_v2,Standard_DS13_v2,Standard_DS14-4_v2,Standard_DS14-8_v2,Standard_DS14_v2,Standard_DS15_v2,Standard_DS2_v2_Promo,Standard_DS3_v2_Promo,Standard_DS4_v2_Promo,Standard_DS5_v2_Promo,Standard_DS11_v2_Promo,Standard_DS12_v2_Promo,Standard_DS13_v2_Promo,Standard_DS14_v2_Promo,Standard_F1s,Standard_F2s,Standard_F4s,Standard_F8s,Standard_F16s,Standard_D2s_v3,Standard_D4s_v3,Standard_D8s_v3,Standard_D16s_v3,Standard_D32s_v3,Standard_D2a_v4,Standard_D4a_v4,Standard_D8a_v4,Standard_D16a_v4,Standard_D32a_v4,Standard_D48a_v4,Standard_D64a_v4,Standard_D96a_v4,Standard_D2as_v4,Standard_D4as_v4,Standard_D8as_v4,Standard_D16as_v4,Standard_D32as_v4,Standard_D48as_v4,Standard_D64as_v4,Standard_D96as_v4,Standard_E2a_v4,Standard_E4a_v4,Standard_E8a_v4,Standard_E16a_v4,Standard_E20a_v4,Standard_E32a_v4,Standard_E48a_v4,Standard_E64a_v4,Standard_E96a_v4,Standard_E2as_v4,Standard_E4-2as_v4,Standard_E4as_v4,Standard_E8-2as_v4,Standard_E8-4as_v4,Standard_E8as_v4,Standard_E16-4as_v4,Standard_E16-8as_v4,Standard_E16as_v4,Standard_E20as_v4,Standard_E32-8as_v4,Standard_E32-16as_v4,Standard_E32as_v4,Standard_E48as_v4,Standard_E64-16as_v4,Standard_E64-32as_v4,Standard_E64as_v4,Standard_E96-24as_v4,Standard_E96-48as_v4,Standard_E96as_v4,Standard_D1_v2,Standard_D2_v2,Standard_D3_v2,Standard_D4_v2,Standard_D5_v2,Standard_D11_v2,Standard_D12_v2,Standard_D13_v2,Standard_D14_v2,Standard_D15_v2,Standard_D2_v2_Promo,Standard_D3_v2_Promo,Standard_D4_v2_Promo,Standard_D5_v2_Promo,Standard_D11_v2_Promo,Standard_D12_v2_Promo,Standard_D13_v2_Promo,Standard_D14_v2_Promo,Standard_F1,Standard_F2,Standard_F4,Standard_F8,Standard_F16,Standard_A1_v2,Standard_A2m_v2,Standard_A2_v2,Standard_A4m_v2,Standard_A4_v2,Standard_A8m_v2,Standard_A8_v2,Standard_D2_v3,Standard_D4_v3,Standard_D8_v3,Standard_D16_v3,Standard_D32_v3,Standard_D48_v3,Standard_D64_v3,Standard_D48s_v3,Standard_D64s_v3,Standard_E2_v3,Standard_E4_v3,Standard_E8_v3,Standard_E16_v3,Standard_E20_v3,Standard_E32_v3,Standard_E48_v3,Standard_E64_v3,Standard_E2s_v3,Standard_E4-2s_v3,Standard_E4s_v3,Standard_E8-2s_v3,Standard_E8-4s_v3,Standard_E8s_v3,Standard_E16-4s_v3,Standard_E16-8s_v3,Standard_E16s_v3,Standard_E20s_v3,Standard_E32-8s_v3,Standard_E32-16s_v3,Standard_E32s_v3,Standard_E48s_v3,Standard_E64-16s_v3,Standard_E64-32s_v3,Standard_E64s_v3,Standard_A0,Standard_A1,Standard_A2,Standard_A3,Standard_A5,Standard_A4,Standard_A6,Standard_A7,Basic_A0,Basic_A1,Basic_A2,Basic_A3,Basic_A4,Standard_E64i_v3,Standard_E64is_v3,Standard_M208ms_v2,Standard_M208s_v2,Standard_M416-208s_v2,Standard_M416s_v2,Standard_M416-208ms_v2,Standard_M416ms_v2,Standard_H8,Standard_H8_Promo,Standard_H16,Standard_H16_Promo,Standard_H8m,Standard_H8m_Promo,Standard_H16m,Standard_H16m_Promo,Standard_H16r,Standard_H16r_Promo,Standard_H16mr,Standard_H16mr_Promo,Standard_D1,Standard_D2,Standard_D3,Standard_D4,Standard_D11,Standard_D12,Standard_D13,Standard_D14,Standard_NV6,Standard_NV12,Standard_NV24,Standard_NV6_Promo,Standard_NV12_Promo,Standard_NV24_Promo,Standard_NC4as_T4_v3,Standard_NC8as_T4_v3,Standard_NC16as_T4_v3,Standard_NC64as_T4_v3,Standard_NV6s_v2,Standard_NV12s_v2,Standard_NV24s_v2,Standard_NV12s_v3,Standard_NV24s_v3,Standard_NV48s_v3,Standard_HB120rs_v2,Standard_NC6s_v2,Standard_NC12s_v2,Standard_NC24rs_v2,Standard_NC24s_v2,Standard_F2s_v2,Standard_F4s_v2,Standard_F8s_v2,Standard_F16s_v2,Standard_F32s_v2,Standard_F48s_v2,Standard_F64s_v2,Standard_F72s_v2,Standard_E2_v4,Standard_E4_v4,Standard_E8_v4,Standard_E16_v4,Standard_E20_v4,Standard_E32_v4,Standard_E48_v4,Standard_E64_v4,Standard_E2d_v4,Standard_E4d_v4,Standard_E8d_v4,Standard_E16d_v4,Standard_E20d_v4,Standard_E32d_v4,Standard_E48d_v4,Standard_E64d_v4,Standard_E2s_v4,Standard_E4-2s_v4,Standard_E4s_v4,Standard_E8-2s_v4,Standard_E8-4s_v4,Standard_E8s_v4,Standard_E16-4s_v4,Standard_E16-8s_v4,Standard_E16s_v4,Standard_E20s_v4,Standard_E32-8s_v4,Standard_E32-16s_v4,Standard_E32s_v4,Standard_E48s_v4,Standard_E64-16s_v4,Standard_E64-32s_v4,Standard_E64s_v4,Standard_E80is_v4,Standard_E2ds_v4,Standard_E4-2ds_v4,Standard_E4ds_v4,Standard_E8-2ds_v4,Standard_E8-4ds_v4,Standard_E8ds_v4,Standard_E16-4ds_v4,Standard_E16-8ds_v4,Standard_E16ds_v4,Standard_E20ds_v4,Standard_E32-8ds_v4,Standard_E32-16ds_v4,Standard_E32ds_v4,Standard_E48ds_v4,Standard_E64-16ds_v4,Standard_E64-32ds_v4,Standard_E64ds_v4,Standard_E80ids_v4,Standard_D2d_v4,Standard_D4d_v4,Standard_D8d_v4,Standard_D16d_v4,Standard_D32d_v4,Standard_D48d_v4,Standard_D64d_v4,Standard_D2_v4,Standard_D4_v4,Standard_D8_v4,Standard_D16_v4,Standard_D32_v4,Standard_D48_v4,Standard_D64_v4,Standard_D2ds_v4,Standard_D4ds_v4,Standard_D8ds_v4,Standard_D16ds_v4,Standard_D32ds_v4,Standard_D48ds_v4,Standard_D64ds_v4,Standard_D2s_v4,Standard_D4s_v4,Standard_D8s_v4,Standard_D16s_v4,Standard_D32s_v4,Standard_D48s_v4,Standard_D64s_v4,Standard_NC6,Standard_NC12,Standard_NC24,Standard_NC24r,Standard_NC6_Promo,Standard_NC12_Promo,Standard_NC24_Promo,Standard_NC24r_Promo,Standard_DS1,Standard_DS2,Standard_DS3,Standard_DS4,Standard_DS11,Standard_DS12,Standard_DS13,Standard_DS14,Standard_L8s_v2,Standard_L16s_v2,Standard_L32s_v2,Standard_L48s_v2,Standard_L64s_v2,Standard_L80s_v2,Standard_DC8_v2,Standard_DC1s_v2,Standard_DC2s_v2,Standard_DC4s_v2,Standard_ND40rs_v2,Standard_FX4mds,Standard_FX12mds,Standard_FX24mds,Standard_FX36mds,Standard_FX48mds,Standard_NP10s,Standard_NP20s,Standard_NP40s,Standard_HC44rs,Standard_ND6s,Standard_ND12s,Standard_ND24rs,Standard_ND24s,Standard_DC2s,Standard_DC4s,Standard_M64,Standard_M64m,Standard_M128,Standard_M128m,Standard_M8-2ms,Standard_M8-4ms,Standard_M8ms,Standard_M16-4ms,Standard_M16-8ms,Standard_M16ms,Standard_M32-8ms,Standard_M32-16ms,Standard_M32ls,Standard_M32ms,Standard_M32ts,Standard_M64-16ms,Standard_M64-32ms,Standard_M64ls,Standard_M64ms,Standard_M64s,Standard_M128-32ms,Standard_M128-64ms,Standard_M128ms,Standard_M128s,Standard_M32ms_v2,Standard_M64ms_v2,Standard_M64s_v2,Standard_M128ms_v2,Standard_M128s_v2,Standard_M192ims_v2,Standard_M192is_v2,Standard_M32dms_v2,Standard_M64dms_v2,Standard_M64ds_v2,Standard_M128dms_v2,Standard_M128ds_v2,Standard_M192idms_v2,Standard_M192ids_v2,Standard_HB120-16rs_v3,Standard_HB120-32rs_v3,Standard_HB120-64rs_v3,Standard_HB120-96rs_v3,Standard_HB120rs_v3,Standard_NV4as_v4,Standard_NV8as_v4,Standard_NV16as_v4,Standard_NV32as_v4,Standard_NC6s_v3,Standard_NC12s_v3,Standard_NC24rs_v3,Standard_NC24s_v3,Standard_PB6s,Standard_HB60rs,Standard_ND96asr_v4,Standard_ND40s_v3. Find out more on the valid VM sizes in each region at https://aka.ms/azure-regions." Target="vmSize"
	│
	│   with module.adminstation.azurerm_linux_virtual_machine.main,
	│   on adminstation/main.tf line 21, in resource "azurerm_linux_virtual_machine" "main":
	│   21: resource "azurerm_linux_virtual_machine" "main" {
	│
	╵
	╷
	│ Error: creating Linux Virtual Machine Scale Set "mylinuxscaleset1" (Resource Group "exploreAZDev"): compute.VirtualMachineScaleSetsClient#CreateOrUpdate: Failure sending request: StatusCode=0 -- Original Error: autorest/azure: Service returned an error. Status=<nil> Code="OperationNotAllowed" Message="Operation could not be completed as it results in exceeding approved Total Regional Cores quota. Additional details - Deployment Model: Resource Manager, Location: eastus, Current Limit: 4, Current Usage: 0, Additional Required: 6, (Minimum) New Limit Required: 6. Submit a request for Quota increase at https://aka.ms/ProdportalCRP/#blade/Microsoft_Azure_Capacity/CapacityExperienceBlade/Parameters/%7B%22subscriptionId%22:%22a4ce1f98-7d76-4418-9612-cd151ae27795%22,%22command%22:%22openQuotaApprovalBlade%22,%22quotas%22:[%7B%22location%22:%22eastus%22,%22providerId%22:%22Microsoft.Compute%22,%22resourceName%22:%22cores%22,%22quotaRequest%22:%7B%22properties%22:%7B%22limit%22:6,%22unit%22:%22Count%22,%22name%22:%7B%22value%22:%22cores%22%7D%7D%7D%7D]%7D by specifying parameters listed in the ‘Details’ section for deployment to succeed. Please read more about quota limits at https://docs.microsoft.com/en-us/azure/azure-supportability/regional-quota-requests"
	│
	│   with module.scaleset.azurerm_linux_virtual_machine_scale_set.main,
	│   on scaleset/main.tf line 1, in resource "azurerm_linux_virtual_machine_scale_set" "main":
	│    1: resource "azurerm_linux_virtual_machine_scale_set" "main" {
	│
	╵
	╷
	│ Error: updating Subnet: (Name "redis" / Virtual Network Name "exploreAZVNet" / Resource Group "exploreAZDev"): network.SubnetsClient#CreateOrUpdate: Failure sending request: StatusCode=0 -- Original Error: Code="InUseSubnetCannotBeUpdated" Message="Subnet redis is in use and cannot be updated." Details=[]
	│
	│   with module.vnet.azurerm_subnet.admin_station,
	│   on vnet/main.tf line 39, in resource "azurerm_subnet" "admin_station":
	│   39: resource "azurerm_subnet" "admin_station" {
	│

Root cause is [Free Trial subscription][2] has 4 vCUP limit and is not eligible for
limit or quota increase.  You have to upgrade to a [Pay-As-You-Go subscription][3].
For more information, see [Upgrade your Azure Free Trial subscription to a
Pay-As-You-Go subscription and the Free Trial subscription FAQ][4]

You may check limit and quota for a given location by:

    ❯ az vm list-usage --location eastus --output table
    Name                                      CurrentValue    Limit
    ----------------------------------------  --------------  -------
    Availability Sets                         0               2500
    Total Regional vCPUs                      0               4
    Virtual Machines                          0               25000
    Virtual Machine Scale Sets                0               2500
    Dedicated vCPUs                           0               0
    Cloud Services                            0               2500
    Total Regional Low-priority vCPUs         0               4
    Standard DSv2 Family vCPUs                0               4
    Basic A Family vCPUs                      0               4
    Standard A0-A7 Family vCPUs               0               4
    Standard A8-A11 Family vCPUs              0               4
    Standard D Family vCPUs                   0               4
    Standard Dv2 Family vCPUs                 0               4
    Standard DS Family vCPUs                  0               4
    Standard G Family vCPUs                   0               4
    Standard GS Family vCPUs                  0               4
    Standard F Family vCPUs                   0               4
    ...... truncated for brevity ......

[1]: https://github.com/hashicorp/terraform-provider-azurerm/issues/7028
[2]: https://azure.microsoft.com/offers/ms-azr-0044p
[3]: https://azure.microsoft.com/offers/ms-azr-0003p/
[4]: https://docs.microsoft.com/en-us/azure/cost-management-billing/manage/upgrade-azure-subscription

