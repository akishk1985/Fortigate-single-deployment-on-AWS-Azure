resource "fortios_router_static" "to-Azure" {
  device = fortios_vpnipsec_phase1interface.to-Azure.name
  dst    = var.Azure-privatecidraz1
  status = "enable"
}
resource "fortios_router_static" "blackhole" {
  blackhole = "enable"
  distance  = 254
  dst       = var.Azure-privatecidraz1
  status    = "enable"
  vrf       = 0
}
