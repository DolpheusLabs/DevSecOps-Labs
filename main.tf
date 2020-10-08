provider "aws" {
  version = 3.9
  profile = "default"
  region  = "us-east-2"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

variable "aws_access_key" {}
variable "aws_secret_key" {}

resource "aws_s3_bucket" "testing" {
  bucket = "security-mountaineering-lab-bucket1"
  acl    = "public-read"
}
