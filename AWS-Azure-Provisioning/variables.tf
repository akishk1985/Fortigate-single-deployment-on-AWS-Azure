variable "Admins-Port" {
  default = "8443"
}

variable "Admin-Username" {

}

variable "Admin-Password" {

}


#AWS Variables
#==================================
variable "AWS-vpccidr" {

}

variable "AWS-publiccidraz1" {

}

variable "AWS-privatecidraz1" {

}

variable "AWS-FGTVM-Size" {
  default = "t2.small"
}



#Azure Variables
#==================================
variable "Azure-vnetcidr" {

}

variable "Azure-publiccidr" {

}

variable "Azure-privatecidr" {

}
variable "Azure-FGTVM-Size" {
  type    = string
  default = "Standard_DS1_v2"
}

variable "license_type" {
  default = "payg"
}

variable "Azure-ResourceGroup" {

}