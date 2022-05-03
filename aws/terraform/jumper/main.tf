resource "aws_instance" "jumper" {
  count = "${var.qty}"

  ami                         = "${var.ami}"
  instance_type               = "${var.instance["type"]}"
  key_name                    = "${var.key["name"]}"
  subnet_id                   = "${var.subnet_id}"
  vpc_security_group_ids      = ["${var.security_group_id}"]
  disable_api_termination     = false
  associate_public_ip_address = true
  user_data                   = templatefile("./cloud-init.tpl", {})

  root_block_device {
    # 30G is max-volume for free-tier
    volume_size = 30
    volume_type = "gp3"
  }

  lifecycle {
    prevent_destroy = false
  }

  timeouts {
    create = "7m"
    delete = "1h"
  }

  tags = {
    Name       = "${var.tags["name"]}"
    App        = "${var.tags["app"]}"
    Maintainer = "${var.tags["maintainer"]}"
    Role       = "${var.tags["role"]}"
  }

  depends_on = [ aws_key_pair.jumper ]

}

resource "aws_key_pair" "jumper" {
  key_name = "${var.key["name"]}"
  public_key = "${var.key["pub"]}"
}
