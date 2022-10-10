provider "google" {
  project = var.project_id
  region  = "us-central1"
  access_token = var.access_token
}

provider "google-beta" {
  project = var.project_id
  region  = "us-central1"
  access_token = var.access_token
}
