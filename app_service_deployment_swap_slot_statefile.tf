
#You can use Azure deployment slots to swap between different versions of your app. 

# This article illustrates an example use of deployment slots by walking you through the deployment of two apps via GitHub and Azure. 
# One app is hosted in a production slot. The second app is hosted in a staging slot. The names "production" and "staging" are arbitrary.
# They can be whatever is appropriate for your scenario. After you configure your deployment slots, you use Terraform to swap between the two slots as needed.

# Configure the Azure provider
provider "azurerm" { 
    # The "feature" block is required for AzureRM provider 2.x. 
    # If you are using version 1.x, the "features" block is not allowed.
    version = "~>2.0"
    features {}
}

resource "azurerm_resource_group" "slotDemo" {
    name = "slotDemoResourceGroup"
    location = "westus2"
}

resource "azurerm_app_service_plan" "slotDemo" {
    name                = "slotAppServicePlan"
    location            = azurerm_resource_group.slotDemo.location
    resource_group_name = azurerm_resource_group.slotDemo.name
    sku {
        tier = "Standard"
        size = "S1"
    }
}

resource "azurerm_app_service" "slotDemo" {
    name                = "slotAppService"
    location            = azurerm_resource_group.slotDemo.location
    resource_group_name = azurerm_resource_group.slotDemo.name
    app_service_plan_id = azurerm_app_service_plan.slotDemo.id
}

resource "azurerm_app_service_slot" "slotDemo" {
    name                = "slotAppServiceSlotOne"
    location            = azurerm_resource_group.slotDemo.location
    resource_group_name = azurerm_resource_group.slotDemo.name
    app_service_plan_id = azurerm_app_service_plan.slotDemo.id
    app_service_name    = azurerm_app_service.slotDemo.name
}


###----------------- swap the slot from Prod to stage-------------


# Configure the Azure provider
provider "azurerm" { 
    # The "feature" block is required for AzureRM provider 2.x. 
    # If you are using version 1.x, the "features" block is not allowed.
    version = "~>2.0"
    features {}
}

# Swap the production slot and the staging slot
resource "azurerm_app_service_active_slot" "slotDemoActiveSlot" {
    resource_group_name   = "slotDemoResourceGroup"
    app_service_name      = "slotAppService"
    app_service_slot_name = "slotappServiceSlotOne"
}
