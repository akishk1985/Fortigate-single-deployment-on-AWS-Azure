
data "terraform_remote_state" "AWS-Azure-Provisioning" {
  backend = "local"

  config = {
    path = "../AWS-Azure-Provisioning/terraform.tfstate"
  }
}


locals {

}


terraform {
  required_providers {
    fortios = {
      source = "fortinetdev/fortios"
    }
  }
}

provider "fortios" {
  alias    = "AWS"
  hostname = "${data.terraform_remote_state.AWS-Azure-Provisioning.outputs.AWS-FGTPublicIP}:8443"
  username = data.terraform_remote_state.AWS-Azure-Provisioning.outputs.Username
  password = data.terraform_remote_state.AWS-Azure-Provisioning.outputs.Password
  insecure = true
}

provider "fortios" {
  alias    = "Azure"
  hostname = "${data.terraform_remote_state.AWS-Azure-Provisioning.outputs.Azure-FGTPublicIP}:8443"
  username = data.terraform_remote_state.AWS-Azure-Provisioning.outputs.Username
  password = data.terraform_remote_state.AWS-Azure-Provisioning.outputs.Password
  insecure = true
}
