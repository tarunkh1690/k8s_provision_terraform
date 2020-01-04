output "instance_ips" {
  value = ["${aws_instance.k8s-server.*.public_ip}"]
  value = ["${aws_instance.k8s-client.*.public_ip}"]
}
