output "ec2_global_ips" {
  value = "${aws_instance.Bastion-Host.*.public_ip}"
}