
module "AWS-Resources-Provisioning" {
  source             = "../modules/AWS-Resources-Provisioning"
  AWS-vpccidr        = var.AWS-vpccidr
  AWS-publiccidraz1  = var.AWS-publiccidraz1
  AWS-privatecidraz1 = var.AWS-privatecidraz1
  size               = var.AWS-FGTVM-Size
  AWS-adminusername  = var.Admin-Username
  AWS-adminpassword  = var.Admin-Password
  AWS-adminsport     = var.Admins-Port
}

module "Azure-Resources-Provisioning" {
  source              = "../modules/Azure-Resources-Provisioning"
  Azure-ResourceGroup = var.Azure-ResourceGroup
  Azure-vnetcidr      = var.Azure-vnetcidr
  Azure-publiccidr    = var.Azure-publiccidr
  Azure-privatecidr   = var.Azure-privatecidr
  size                = var.Azure-FGTVM-Size
  Azure-adminusername = var.Admin-Username
  Azure-adminpassword = var.Admin-Password
  Azure-adminsport    = var.Admins-Port
}

