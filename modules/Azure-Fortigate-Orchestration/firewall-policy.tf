
resource "fortios_firewall_address" "AWS-Private-Subnet" {
  name   = "AWS-Private-Subnet"
  subnet = var.AWS-privatecidraz1 # Replace with the desired subnet or IP address range
}

resource "fortios_firewall_address" "Azure-Private-Subnet" {
  name   = "Azure-Private-Subnet"
  subnet = var.Azure-privatecidraz1 # Replace with the desired subnet or IP address range
}


resource "fortios_firewall_policy" "inbound" {
  action     = "accept"
  logtraffic = "all"
  name       = "inbound"

  dstaddr {
    name = fortios_firewall_address.Azure-Private-Subnet.name
  }

  dstintf {
    name = "port2"
  }

  service {
    name = "ALL"
  }

  srcaddr {
    name = fortios_firewall_address.AWS-Private-Subnet.name
  }

  srcintf {
    name = fortios_vpnipsec_phase1interface.to-AWS.name
  }
}

resource "fortios_firewall_policy" "outbound" {
  action     = "accept"
  logtraffic = "all"
  name       = "outbound"

  dstaddr {
    name = fortios_firewall_address.AWS-Private-Subnet.name
  }

  dstintf {
    name = fortios_vpnipsec_phase1interface.to-AWS.name
  }

  service {
    name = "ALL"
  }

  srcaddr {
    name = fortios_firewall_address.Azure-Private-Subnet.name
  }

  srcintf {
    name = "port2"
  }
}

resource "fortios_firewall_policy" "internet" {
  action     = "accept"
  logtraffic = "all"
  name       = "internet"
  nat        = "enable"

  dstaddr {
    name = "all"
  }

  dstintf {
    name = "port1"
  }

  service {
    name = "ALL"
  }

  srcaddr {
    name = fortios_firewall_address.Azure-Private-Subnet.name
  }

  srcintf {
    name = "port2"
  }
}



resource "fortios_firewall_policy" "to-internal-vm" {
  action     = "accept"
  logtraffic = "all"
  name       = "to-internal-vm"
  nat        = "enable"

  dstaddr {
    name = fortios_firewall_vip.to-internal-VM.name
  }

  dstintf {
    name = "port2"
  }

  service {
    name = "SSH"
  }

  srcaddr {
    name = "all"
  }

  srcintf {
    name = "port1"
  }
}
