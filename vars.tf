variable "profile" {
  default = "Chef-Client"
}

variable "security_group" {
  default = "sg-021f2b4cb2952db03"
}
variable "aws_key_pair" {
  default = "robinjack1690"
}

variable "instance_count" {
  default = "3"
}

variable "aws_region" {
  default = "ap-south-1"
}
variable "AMIS" {
  default = {
    ap-south-1 = "ami-0123b531fc646552f"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-0d729a60"
  }
}
