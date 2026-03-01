resource "pihole_ad_blocker_status" "status" {
  enabled = true
}

resource "pihole_group" "work" {
  enabled = true
  name = "Work"
  description = "Devices used for work"
}
