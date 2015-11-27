resource "aws_instance" "bastion" {
  instance_type = "t2.micro"
  ami = "${lookup(var.ubuntu_1404_amis, var.region)}"
  subnet_id = "${aws_subnet.public_1_static.id}"
  private_ip = "10.0.15.10"

  user_data = "${file(\"../provision/bastion/cloud-config\")}"

  security_groups = ["${aws_security_group.vpc.id}","${aws_security_group.ssh.id}"]
  key_name = "${aws_key_pair.aws_meetup.key_name}"

  tags = { 
    Name = "Bastion 1"
  }
}
