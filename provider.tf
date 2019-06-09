# Specify the provider (GCP, AWS, Azure)
provider "google" {
credentials = "${file("yourproject.json")}"
project = "vast-math-240911"
region = "asia-southeast1"
zone = "asia-southeast1-b"
}