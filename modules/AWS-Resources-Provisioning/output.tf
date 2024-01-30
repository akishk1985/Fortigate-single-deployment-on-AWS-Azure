
output "AWS-Internal-Host-IP" {
  value = aws_instance.Ubuntu-AWS.private_ip
}

output "AWS-FGTPublicIP" {
  value = aws_eip.FGTPublicIP.public_ip
}

output "AWS-adminsport" {
  value = var.AWS-adminsport
}

output "AWS-Username" {
  value = var.AWS-adminusername
}

output "AWS-Password" {
  value = var.AWS-adminpassword
}

output "AWS-privatecidraz1" {
  value = var.AWS-privatecidraz1
}

output "AWS-FGTPrivateIP" {
  value = aws_network_interface.eth0.private_ip
}
