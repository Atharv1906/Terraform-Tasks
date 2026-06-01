terraform {
  backend "s3" {
    bucket = "cmtr-f8mezz9s-backend-bucket-1780320382"
    key    = "tf_code.tfstate"
    region = "eu-west-1"
  }
}