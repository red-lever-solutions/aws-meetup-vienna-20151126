resource "aws_instance" "nat" {
  instance_type = "t2.micro"
  ami = "ami-ef76e898"
  subnet_id = "${aws_subnet.public_1.id}"
  source_dest_check = false

  security_groups = ["${aws_security_group.vpc.id}"]
  key_name = "${aws_key_pair.aws_meetup.key_name}"

  tags = { 
    Name = "NAT 1"
  }
}
