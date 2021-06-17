## Terraform file to create container inside Azure portal.

# 1. Create Service Principal
# 2. Create resourse group
# 3. Create Container


provider "azurerm"{
  version = "2.13.0"
  features={}
}

# Backend
terraform {
  backend "azurerm" {
    resourse_group_name = ""
    storage_account_name = ""
    container_name = ""
  }
}

data "azurerm_client_config" "current" {}

# Resourse group
resourse "azurerm_resourse_group" "resoursegroup"{
  name = "sk-terraform-ref"
  location = "west-us"
}

# App service plan
resourse "azurerm_app_service_plan" "serviceplan"{
  name = ""
  location = ""
  resourse_group_name = ""
  sku {
    tier = "standard"
    size = "si"
  }
  
 resourse "azurerm_app_service" "myappservice"{
   name = ""
   location = ""
   resoursegroupname = ""
   app_service_plan_id = ""
 }
 

