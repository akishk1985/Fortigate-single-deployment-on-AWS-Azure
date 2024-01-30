output "Username" {
  value = module.AWS-Resources-Provisioning.AWS-Username
}

output "Password" {
  value = module.AWS-Resources-Provisioning.AWS-Password
}

output "FGTVM-adminsport" {
  value = module.AWS-Resources-Provisioning.AWS-adminsport
}


#AWS Outputs
#==================================
output "AWS-Internal-Host-IP" {
  value = module.AWS-Resources-Provisioning.AWS-Internal-Host-IP
}

output "AWS-FGTPublicIP" {
  value = module.AWS-Resources-Provisioning.AWS-FGTPublicIP
}

output "AWS-privatecidraz1" {
  value = module.AWS-Resources-Provisioning.AWS-privatecidraz1
}

output "AWS-FGTPrivateIP" {
  value = module.AWS-Resources-Provisioning.AWS-FGTPrivateIP
}

#Azure Outputs
#==================================
output "Azure-ResourceGroup" {
  value = module.Azure-Resources-Provisioning.ResourceGroup
}

output "Azure-Internal-Host-IP" {
  value = module.Azure-Resources-Provisioning.Azure-Internal-Host-IP
}

output "Azure-FGTPublicIP" {
  value = module.Azure-Resources-Provisioning.Azure-FGTPublicIP
}

output "Azure-privatecidr" {
  value = module.Azure-Resources-Provisioning.Azure-privatecidr
}

output "Azure-FGTPrivateIP" {
  value = module.Azure-Resources-Provisioning.Azure-FGTPrivateIP
}
