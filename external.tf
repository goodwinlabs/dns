data "http" "public_ip" {
  url = "https://ifconfig.me/ip"
}

data "cloudflare_zone" "ryanjgoodwin_com" {
  zone_id = "9945ffa50f42da81c5aafebbeadef051"
}

locals {
  services = yamldecode(file("${path.module}/external-dns.yaml"))
}

resource "cloudflare_dns_record" "base" {
  zone_id = data.cloudflare_zone.ryanjgoodwin_com.id
  name    = "home"
  content = sensitive(data.http.public_ip.response_body)
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "cloudflare_dns_record" "root" {
  zone_id = data.cloudflare_zone.ryanjgoodwin_com.id
  name    = "@"
  content = "192.1.2.1"
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "cloudflare_dns_record" "www" {
  zone_id = data.cloudflare_zone.ryanjgoodwin_com.id
  name    = "www"
  content = data.cloudflare_zone.ryanjgoodwin_com.name
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

module "proxy_service" {
  source   = "./modules/proxy_service"
  for_each = local.services

  name        = each.value.name
  zone_id     = data.cloudflare_zone.ryanjgoodwin_com.id
  base_record = cloudflare_dns_record.base.name
  # ip          = sensitive(data.http.public_ip.response_body)

  forward_host            = each.value.forward_host
  forward_port            = each.value.forward_port
  forward_scheme          = lookup(each.value, "forward_scheme", "http")
  letsencrypt_email       = var.letsencrypt_email
  proxied                 = lookup(each.value, "proxied", true)
  caching_enabled         = lookup(each.value, "caching_enabled", true)
  allow_websocket_upgrade = lookup(each.value, "allow_websocket_upgrade", false)
  advanced_config         = lookup(each.value, "advanced_config", "")
}

