variable "pihole_url" {
  description = "URL/IP of the pihole instance"
  type        = string
}

variable "pihole_app_password" {
  description = "The app password for pihole"
  type        = string
  sensitive   = true
}

variable "internal_domain_suffix" {
  description = "The domain suffix for internal DNS entries"
  type        = string
  default     = "in.goodwinlabs.dev"
}

variable "npm_url" {
  description = "URL/IP of the Nginx Proxy Manager instance"
  type        = string
}

variable "npm_username" {
  description = "email to log into Nginx Proxy Manager"
  type        = string
}

variable "npm_password" {
  description = "password to access Nginx Proxy Manager"
  type        = string
  sensitive   = true
}

variable "letsencrypt_email" {
  description = "Email address for Let's Encrypt notifications"
  type        = string
}

variable "cloudflare_api_token" {
  description = "API token for Cloudflare DNS management"
  type        = string
  sensitive   = true
}
