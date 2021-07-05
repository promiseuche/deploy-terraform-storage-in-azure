provider "azurerm" {
    version = "=2.46.0"
    features {}
}

terraform {
    backend "azurerm" {
        resource_group_name = "terraform-rg"
        storage_account_name = "sktfaccountorial"
        container_name = "terraform.tfstate"
    }
}

data "azure_client_config" "current" {}

resource "azurerm_resource_group" "resourcegroup" {
    name = "sk-terraform-rg"
    location = "west us"
}

resource "azurerm_app_service_plan" "serviceplan" {
    name = "terraform-sp"
    location = azurerm_resource_group.resourcegroup.location
    resource_group_name = azurerm_resource_group.resourcegroup.name

    sku {
        tier = "Standard"
        size = "S1"
    }
}

resource "azurerm_app_service" "appservice" {
    name = "terraform-as"
    location = azurerm_resource_group.resourcegroup.location
    resource_group_name = azurerm_resource_group.resourcegroup.name
    app_service_plan_id = azurerm_app_service_plan.serviceplan.id
}