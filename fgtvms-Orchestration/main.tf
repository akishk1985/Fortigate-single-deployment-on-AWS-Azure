
module "AWS-Fortigate-Orchestration" {
  source               = "../modules/AWS-Fortigate-Orchestration"
  remote_gw            = data.terraform_remote_state.AWS-Azure-Provisioning.outputs.Azure-FGTPublicIP
  PSK                  = var.PSK
  Azure-privatecidraz1 = data.terraform_remote_state.AWS-Azure-Provisioning.outputs.Azure-privatecidr
  AWS-privatecidraz1   = data.terraform_remote_state.AWS-Azure-Provisioning.outputs.AWS-privatecidraz1
  VIP-extip = data.terraform_remote_state.AWS-Azure-Provisioning.outputs.AWS-FGTPrivateIP
  VIP-extport = var.VIP-extport
  VIP-mappedip = data.terraform_remote_state.AWS-Azure-Provisioning.outputs.AWS-Internal-Host-IP
  VIP-mappedport = var.VIP-mappedport
  
  providers = {
    fortios = fortios.AWS
  }
}

module "Azure-Fortigate-Orchestration" {
  source               = "../modules/Azure-Fortigate-Orchestration"
  remote_gw            = data.terraform_remote_state.AWS-Azure-Provisioning.outputs.AWS-FGTPublicIP
  PSK                  = var.PSK
  Azure-privatecidraz1 = data.terraform_remote_state.AWS-Azure-Provisioning.outputs.Azure-privatecidr
  AWS-privatecidraz1   = data.terraform_remote_state.AWS-Azure-Provisioning.outputs.AWS-privatecidraz1
  VIP-extip = data.terraform_remote_state.AWS-Azure-Provisioning.outputs.Azure-FGTPrivateIP
  VIP-extport = var.VIP-extport
  VIP-mappedip = data.terraform_remote_state.AWS-Azure-Provisioning.outputs.Azure-Internal-Host-IP
  VIP-mappedport = var.VIP-mappedport

  providers = {
    fortios = fortios.Azure
  }
}

