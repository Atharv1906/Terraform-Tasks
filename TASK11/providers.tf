terraform {
  backend "s3" {
    bucket = "cmtr-f8mezz9s-backend-new-bucket-1780317820"
    key    = "tf_code.tfstate"
    region = "eu-west-1"
  }
}