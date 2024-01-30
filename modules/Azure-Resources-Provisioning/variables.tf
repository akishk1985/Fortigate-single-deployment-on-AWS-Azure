/*
// Azure configuration
variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
*/


variable "location" {
  type    = string
  default = "eastus"
}

variable "Azure-vnetcidr" {}

variable "Azure-publiccidr" {}

variable "Azure-privatecidr" {}


variable "size" {
  type    = string
  default = "Standard_DS1_v2"
}

// To use custom image
// by default is false
variable "custom" {
  default = false
}

// License Type to create FortiGate-VM
// Provide the license type for FortiGate-VM Instances, either byol or payg.
variable "license_type" {
  default = "payg"
}

variable "publisher" {
  type    = string
  default = "fortinet"
}

variable "fgtoffer" {
  type    = string
  default = "fortinet_fortigate-vm_v5"
}

// BYOL sku: fortinet_fg-vm
// PAYG sku: fortinet_fg-vm_payg_2022
variable "fgtsku" {
  type = map(any)
  default = {
    byol = "fortinet_fg-vm"
    payg = "fortinet_fg-vm_payg_2023"
  }
}

variable "fgtversion" {
  type    = string
  default = "7.4.2"
}

variable "Azure-adminusername" {}
variable "Azure-adminpassword" {}
variable "bootstrap-fgtvm" {
  // Change to your own path
  type    = string
  default = "Azure-fgtvm.conf"
}

// license file for the fgt
variable "license" {
  // Change to your own byol license file, license.lic
  type    = string
  default = "license.txt"
}

variable "Azure-adminsport" {}


variable "Azure-ResourceGroup" {
  default = "terraform-single-fgt"
}
