terraform {
  backend "s3" {
    bucket = "nilesh-atc-assessment-tf-state"
    key    = "eks/terraform.tfstate"
    region = "ap-south-1"
  }
}