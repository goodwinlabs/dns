data "http" "public_ip" {
  url = "https://ifconfig.me/ip"
}

data "cloudflare_zone" "ryanjgoodwin_com" {
  zone_id = "9945ffa50f42da81c5aafebbeadef051"
}

locals {
  services = jsondecode(file("${path.module}/external-dns.json"))
}

module "proxy_service" {
  source = "./modules/proxy_service"
  for_each = local.services

  name                  = each.value.name
  zone_id               = data.cloudflare_zone.ryanjgoodwin_com.id
  ip                    = data.http.public_ip.response_body
  forward_host          = each.value.forward_host
  forward_port          = each.value.forward_port
  forward_scheme        = lookup(each.value, "forward_scheme", "http")
  letsencrypt_email     = var.letsencrypt_email
  proxied               = lookup(each.value, "proxied", true)
  caching_enabled       = lookup(each.value, "caching_enabled", true)
  allow_websocket_upgrade = lookup(each.value, "allow_websocket_upgrade", false)
  advanced_config       = lookup(each.value, "advanced_config", "")
}

