variable "resource_group_name" {
 type        = string
 description = "MyDemoResourceGroup"
}
variable "app_service_plan_name" {
 type        = string
 description = "app service plan name"
}
variable "app_service_name" {
 type        = string
 description = "app service name"
}
variable "mysql-server-Name" {
  type = string
  description = "mysql-server-appservice123"
}
variable "location" {
 type        = string
 description = "eastasia"
}
variable "subscription_id" {
  type        = string
  description = "3f377b8c-fe27-471e-965d-8ca68e8a7b5b"
}

variable "tenant_id" {
  type        = string
  description = "94152326-4f97-4171-a85c-e7ec5c388502"
}

variable "client_id" {
  type        = string
  description = "308dd1a8-9fb0-41da-b3a1-2ff4f8cd6910"
}

variable "client_secret" {
  type        = string
  description = "18ea48d9-ae0d-445e-8a62-7f48af15c20e"
}
variable "administrator_login" {
  type        = string
  description = "enter database admin login name"
}
variable "administrator_login_password"{
  type = string
  description = "DB administrator_login_password"
}