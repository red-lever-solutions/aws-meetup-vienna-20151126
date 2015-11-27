resource "aws_security_group" "vpc" {
  name = "vpc"
  vpc_id = "${aws_vpc.production.id}"
  
  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = true
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ssh" {
  name = "SSH Access to Bastion"
  vpc_id = "${aws_vpc.production.id}"

  ingress {
    from_port = 10022
    to_port   = 10022
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "http" {
  name = "http"
  vpc_id = "${aws_vpc.production.id}"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
