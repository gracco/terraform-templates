resource "aws_instance" "default" {
  connection {
    user = "${var.user}"
  }

  instance_type = "${var.instance_type}"
  ami = "${var.ami}"
  key_name = "${var.key_name}"

  vpc_security_group_ids = ["${aws_security_group.default.id}"]

  subnet_id = "${var.subnets["InternalSubnetA"]}"
  #associate_public_ip_address = true

  tags {
    Name = "${var.hostname}-0${count.index+1}"
  }

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = "${file("~/.ssh/acme.pem")}"
    }
    #This python3 it's for a future ansible run
    inline = [
      "sudo hostnamectl set-hostname ${var.hostname}-0${count.index+1}.acme.co",
      "sudo ln -s /usr/bin/python3 /usr/bin/python"
    ]
  }
  count = "${var.count}"
}
