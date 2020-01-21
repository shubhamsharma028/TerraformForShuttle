resource "azurerm_resource_group" "rg" {
 name     = var.resource_group_name
 location = var.location
}
resource "azurerm_app_service_plan" "rg" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}
resource "azurerm_mysql_server" "rg" {
  name                = var.mysql-server-Name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku_name = "B_Gen5_2"

  storage_profile {
    storage_mb            = 5120
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
  }

  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  version                      = "5.7"
  ssl_enforcement              = "Enabled"
}
resource "azurerm_mysql_firewall_rule" "allow_all_azure_ips" {
  name                = "AllowAllAzureIps"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_server.rg.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}
resource "azurerm_mysql_database" "rg" {
  name                = "MyShuttleDatabase"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_server.rg.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}
resource "azurerm_app_service" "rg" {
  name                = var.app_service_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.rg.id

  site_config {
     java_version           = "1.8"
     java_container         = "TOMCAT"
     java_container_version = "1.8"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "MySQL"
    value = "Server=tcp:${azurerm_mysql_server.rg.fqdn} Database=${azurerm_mysql_database.rg.name};User ID=${var.administrator_login};Password=${var.administrator_login_password};Trusted_Connection=False;Encrypt=True;"
  }
}

