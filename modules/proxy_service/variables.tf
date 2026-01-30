variable "name" {
  description = "Subdomain name (left-hand label) for the DNS record"
  type        = string
}

variable "zone_id" {
  description = "Cloudflare zone id"
  type        = string
}

variable "ip" {
  description = "IP address for the A record"
  type        = string
}

variable "forward_host" {
  description = "Internal host to forward to (IP or hostname)"
  type        = string
}

variable "forward_port" {
  description = "Port on the forward host"
  type        = number
}

variable "forward_scheme" {
  description = "Scheme to forward (http/https)"
  type        = string
  default     = "http"
}

variable "letsencrypt_email" {
  description = "Email for Let's Encrypt registration"
  type        = string
}

variable "proxied" {
  description = "Whether the Cloudflare record is proxied"
  type        = bool
  default     = true
}

variable "caching_enabled" {
  description = "Enable caching on proxy host"
  type        = bool
  default     = true
}

variable "allow_websocket_upgrade" {
  description = "Allow websocket upgrades on the proxy host"
  type        = bool
  default     = false
}

variable "advanced_config" {
  description = "Advanced Nginx config to apply to the proxy host"
  type        = string
  default     = ""
}
