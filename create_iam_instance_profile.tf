resource "aws_iam_instance_profile" "test_profile" {
  name  = "test_profile"
  roles = ["${aws_iam_role.ec2_s3_access_role.name}"]
}
