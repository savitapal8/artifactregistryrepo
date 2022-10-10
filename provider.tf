provider "google" {
  project = "modular-scout-345114"
  region  = "us-central1"
  access_token = var.access_token
}

provider "google-beta" {
  project = "modular-scout-345114"
  region  = "us-central1"
  access_token = var.access_token
}
