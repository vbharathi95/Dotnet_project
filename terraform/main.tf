terraform {
    required_providers {
    azurerm = {
    source  = "hashicorp/azurerm"
    version = ">= 3.1"
  }
}
}
provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "rg" {
  name     = var.rg
  location = var.location
}
resource "azurerm_service_plan" "asp" {
  name                = var.asp
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Windows"
  sku_name           = "S1"
}
resource "azurerm_windows_web_app" "webapp" {
  name                = var.webapp
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id = azurerm_service_plan.asp.id
  site_config {
    application_stack {
      dotnet_version = "v10.0"
      current_stack = "dotnetcore"
    }
  }
}