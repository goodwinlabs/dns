Module `proxy_service`

Creates a Cloudflare A record, a Let's Encrypt certificate via Nginx Proxy Manager, and an Nginx Proxy Manager proxy host for a single service.

Inputs
- `name`, `zone_id`, `ip`, `forward_host`, `forward_port`, `letsencrypt_email`
- Optional: `forward_scheme`, `proxied`, `caching_enabled`, `allow_websocket_upgrade`, `advanced_config`

Outputs
- `dns_name`, `proxy_host_id`, `certificate_id`
