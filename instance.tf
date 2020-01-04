resource "aws_instance" "k8s-server" {
  ami           = "${lookup(var.AMIS, var.aws_region)}"
  instance_type = "t2.micro"
  #roles = ["${aws_iam_role.ec2_s3_access_role.name}"]
  iam_instance_profile = "${aws_iam_instance_profile.test_profile.name}"
  key_name = "robinjack1690"
  tags = {
          Name = "k8s-server"
         }


  provisioner "file" {
    source      = "k8smaster_script.sh"
    destination = "/tmp/k8smaster_script.sh"
   
    connection {
      type     = "ssh"
      user     = "ubuntu"
      #host_key = "${file("./robinjack1690.pub")}"
      private_key = "${file("~/.ssh/id_rsa")}"
      #host     = "${aws_instance.k8s-server.*.public_ip}"
      }

  }
 
 provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/k8smaster_script.sh",
      "/tmp/k8smaster_script.sh",
    ]

    connection {
      type     = "ssh"
      user     = "ubuntu"
      #host_key = "${file("./robinjack1690.pub")}"
      private_key = "${file("~/.ssh/id_rsa")}"
      #host     = "${aws_instance.k8s-server.*.public_ip}"
      }

  }

  timeouts {
    create = "10m"
    }

  depends_on = [ "aws_s3_bucket.bucket", "aws_iam_role.ec2_s3_access_role"]
}


resource "aws_instance" "k8s-client" {
  count = "${var.instance_count}"
  ami           = "${lookup(var.AMIS, var.aws_region)}"
  instance_type = "t2.medium"
  iam_instance_profile = "${aws_iam_instance_profile.test_profile.name}"
  key_name = "robinjack1690"
  tags = {
          Name = "k8s-client-${count.index + 1}"
         }

  provisioner "file" {
    source      = "k8sclient_script.sh"
    destination = "/tmp/k8sclient_script.sh"
   
    connection {
      type     = "ssh"
      user     = "ubuntu"
      #host_key = "${file("./robinjack1690.pub")}"
      private_key = "${file("~/.ssh/id_rsa")}"
      #host     = "${aws_instance.k8s-server.*.public_ip}"
      }

  }
 
 provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/k8sclient_script.sh",
      "/tmp/k8sclient_script.sh",
    ]

    connection {
      type     = "ssh"
      user     = "ubuntu"
      #host_key = "${file("./robinjack1690.pub")}"
      private_key = "${file("~/.ssh/id_rsa")}"
      #host     = "${aws_instance.k8s-server.*.public_ip}"
      }

   }

  depends_on = [ "aws_instance.k8s-server", "aws_iam_role.ec2_s3_access_role"]

}
