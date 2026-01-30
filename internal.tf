locals {
  internal_dns = jsondecode(file("${path.module}/internal-dns.json"))

  # Map internal_dns keyed by proxy_domain for easy for_each usage
  internal_dns_map = { for entry in local.internal_dns : entry.proxy_domain => entry }

  # Build a list of CNAME records (one per domain) then convert to a map keyed by "proxy|name"
  cname_list = flatten([
    for proxy, entry in local.internal_dns_map : [
      for d in entry.domains : {
        key    = "${proxy}|${d}"
        fqdn   = "${d}.${var.internal_domain_suffix}"
        target = proxy
        name   = d
      }
    ]
  ])

  cname_map = { for rec in local.cname_list : rec.key => rec }
}

resource "pihole_dns_record" "proxy" {
  for_each = local.internal_dns_map
  domain   = "${each.key}.${var.internal_domain_suffix}"
  ip       = each.value.ip
}

resource "pihole_cname_record" "service" {
  for_each = local.cname_map
  domain   = each.value.fqdn
  target   = pihole_dns_record.proxy[each.value.target].domain
}