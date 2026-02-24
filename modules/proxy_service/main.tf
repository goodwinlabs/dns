resource "cloudflare_dns_record" "record" {
  zone_id = var.zone_id
  name    = var.name
  content = var.base_record != null ? var.base_record : var.ip
  type    = var.base_record != null ? "CNAME" : "A"
  ttl     = 1
  proxied = var.proxied
}

resource "nginxproxymanager_certificate_letsencrypt" "cert" {
  domain_names      = [cloudflare_dns_record.record.name]
  letsencrypt_email = var.letsencrypt_email
  letsencrypt_agree = true
}

resource "nginxproxymanager_proxy_host" "proxy" {
  domain_names   = [cloudflare_dns_record.record.name]
  forward_scheme = var.forward_scheme
  forward_host   = var.forward_host
  forward_port   = var.forward_port

  certificate_id = nginxproxymanager_certificate_letsencrypt.cert.id
  ssl_forced     = false

  block_exploits  = true
  caching_enabled = var.caching_enabled
  allow_websocket_upgrade = var.allow_websocket_upgrade

  advanced_config = var.advanced_config
}
