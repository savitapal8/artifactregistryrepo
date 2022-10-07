### Artifact Registry fail scenario 
## google_artifact_registry.repository.kms_key_name

# Required Google APIs

locals {
  googleapis = ["artifactregistry.googleapis.com", ]
}

# Enable required services
resource "google_project_service" "apis" {
  for_each           = toset(local.googleapis)
  project            = var.project_id
  service            = each.key
  disable_on_destroy = false
}

# Pull the Composer Service Agent

resource "google_project_service_identity" "sa_identity" {
  provider = google-beta
  project  = var.project_id
  service  = "artifactregistry.googleapis.com"
}

# Creation of key_ring
# resource "google_kms_key_ring" "example-keyring" {
#   name     = "keyring-example1031"
#   location = "us-central1"
#   depends_on = [
#     google_project_service.apis
#   ]
# }

# Create a KMS key within the provided KMS key-ring
# resource "google_kms_crypto_key" "key" {
#   name     = "key1031"
#   key_ring = google_kms_key_ring.example-keyring.id
# }

# GAR Repository Resource with CMEK
resource "google_artifact_registry_repository" "my-repo" {
  location      = "us-central1"
  repository_id = "my-repository"
  description   = "example docker repository with cmek"
  format        = "DOCKER"
  # kms_key_name  = google_kms_crypto_key.key.id
  #   depends_on = [
  #     google_kms_crypto_key_iam_member.crypto_key
  #   ]
}

# Grant cryptoKeyEncrypterDecrypter role to Artifact Registry Service Agent
# resource "google_kms_crypto_key_iam_member" "crypto_key" {
#   crypto_key_id = google_kms_crypto_key.key.id
#   role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
#   member        = "serviceAccount:${google_project_service_identity.sa_identity.email}"
# }

# Granting Artifact Registry repoAdmin role to Application Service Account
resource "google_artifact_registry_repository_iam_member" "repo" {
  project    = var.project_id
  location   = "us-central1"
  repository = google_artifact_registry_repository.my-repo.name
  role       = "roles/artifactregistry.repoAdmin"
  member     = "serviceAccount:${google_project_service_identity.sa_identity.email}"
}


