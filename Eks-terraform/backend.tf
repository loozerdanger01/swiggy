terraform {
  backend "s3" {
    bucket = "swiggy27062024" # Replace with your actual S3 bucket name
    key    = "EKS/terraform.tfstate"
    region = "ap-south-1"
  }
}
