terraform {
  backend "s3" {
    bucket         = "fddfdfd"      # تأكد من أن هذا الـ Bucket موجود
    key            = "terraform.tfstate"
    region         = "us-east-1"   
    encrypt        = true
    acl            = "bucket-owner-full-control"
    dynamodb_table = "new-terraform-locks"  # تأكد من أن الجدول موجود
  }
}
