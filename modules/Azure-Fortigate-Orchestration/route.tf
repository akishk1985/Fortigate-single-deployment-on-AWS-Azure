resource "fortios_router_static" "to-AWS" {
  device = fortios_vpnipsec_phase1interface.to-AWS.name
  dst    = var.AWS-privatecidraz1
  status = "enable"
}
resource "fortios_router_static" "blackhole" {
  blackhole = "enable"
  distance  = 254
  dst       = var.AWS-privatecidraz1
  status    = "enable"
  vrf       = 0
}
