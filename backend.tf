terraform {
  required_version = ">=1.13"

  backend "s3" {}

  required_providers {
    pihole = {
      source  = "ryanwholey/pihole"
      version = "2.0.0-beta.1"
    }

    nginxproxymanager = {
      source  = "sander0542/nginxproxymanager"
      version = "~> 1"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
}

provider "pihole" {
  url      = var.pihole_url
  password = var.pihole_app_password
}

provider "nginxproxymanager" {
  url      = var.npm_url
  username = var.npm_username
  password = var.npm_password
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}