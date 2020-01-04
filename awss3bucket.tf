resource "aws_s3_bucket" "bucket" {
  bucket = "k8s-join-master"
  acl    = "private"

  tags = {
    Name        = "k8s-join-master"
  }
}
