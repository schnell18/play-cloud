output "Hostname" {
  value = "${aws_instance.jumper.*.public_dns}"
}


output "IP" {
  value = "${aws_instance.jumper.*.public_ip}"
}


output "SSHKey" {
  value = "${aws_instance.jumper.*.key_name}"
}
