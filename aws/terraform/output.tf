output "Hostname" {
  value = "${aws_instance.poincare.*.public_dns}"
}


output "IP" {
  value = "${aws_instance.poincare.*.public_ip}"
}


output "SSH_Key" {
  value = "${aws_instance.poincare.*.key_name}"
}
