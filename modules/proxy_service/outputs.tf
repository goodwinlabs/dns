output "dns_name" {
  value = cloudflare_dns_record.record.name
}

output "proxy_host_id" {
  value = nginxproxymanager_proxy_host.proxy.id
}

output "certificate_id" {
  value = nginxproxymanager_certificate_letsencrypt.cert.id
}
