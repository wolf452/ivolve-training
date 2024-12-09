terraform {
  backend "s3" {
    bucket         = "ivolve"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    acl            = "bucket-owner-full-control"
    dynamodb_table = "new-terraform-locks"
  }
}
