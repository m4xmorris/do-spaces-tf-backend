terraform {
  backend "s3" {
    bucket = "name-of-bucket"
    key    = "terraform.tfstate" # Path to use within bucket
    region = "us-east-1" # Always leave this set at "us-east-1"
    endpoint = "https://fra1.digitaloceanspaces.com" # Found in Spaces UI or digitalocean_spaces_bucket.bucket.endpoint
    skip_credentials_validation = true # Necessary to bypass AWS'ness
    skip_metadata_api_check = true # Necessary to bypass AWS'ness
  }
}

resource "digitalocean_spaces_bucket" "bucket" {
  name   = "name-of-bucket"
  region = "fra1" # https://docs.digitalocean.com/products/spaces/details/availability/
  versioning {enabled = "true"}
  acl = "private"
}

# Attach bucket to a project
resource "digitalocean_project_resources" "name-of-project" {
  project = digitalocean_project.name-of-project.id
  resources = [digitalocean_spaces_bucket.name-of-bucket.urn]
}
