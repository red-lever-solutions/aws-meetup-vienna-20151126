resource "aws_instance" "consul_1" {
  instance_type = "t2.micro"
  ami = "${lookup(var.ubuntu_1404_amis, var.region)}"
  subnet_id = "${aws_subnet.private_1_static.id}"
  private_ip = "10.0.5.10"

  security_groups = ["${aws_security_group.vpc.id}"]
  key_name = "${aws_key_pair.aws_meetup.key_name}"

  user_data = "${file(\"../provision/consul-server/cloud-config\")}"

  tags = { 
    Name = "Consul 1"
  }
}


resource "aws_instance" "consul_2" {
  instance_type = "t2.micro"
  ami = "${lookup(var.ubuntu_1404_amis, var.region)}"
  subnet_id = "${aws_subnet.private_2_static.id}"
  private_ip = "10.0.6.10"

  security_groups = ["${aws_security_group.vpc.id}"]
  key_name = "${aws_key_pair.aws_meetup.key_name}"

  user_data = "${file(\"../provision/consul-server/cloud-config\")}"

  tags = { 
    Name = "Consul 2"
  }
}


resource "aws_instance" "consul_3" {
  instance_type = "t2.micro"
  ami = "${lookup(var.ubuntu_1404_amis, var.region)}"
  subnet_id = "${aws_subnet.private_3_static.id}"
  private_ip = "10.0.7.10"

  security_groups = ["${aws_security_group.vpc.id}"]
  key_name = "${aws_key_pair.aws_meetup.key_name}"

  user_data = "${file(\"../provision/consul-server/cloud-config\")}"

  tags = { 
    Name = "Consul 3"
  }
}
