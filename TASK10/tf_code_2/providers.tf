terraform {
  backend "s3" {
    bucket = "cmtr-f8mezz9s-backend-bucket-1780316559"
    key    = "tf_code_2.tfstate"
    region = "eu-west-1"
  }
}