provider "aws" {
  version = 3.9
  profile = "default"
  region  = "us-west-2"
}

resource "aws_s3_bucket" "testing" {
  bucket = "security-mountaineering-lab-bucket1"
  acl    = "public-read"
}
