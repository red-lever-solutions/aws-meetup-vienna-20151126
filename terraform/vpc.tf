#VPC
resource "aws_vpc" "production" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
}


#Private subnets
resource "aws_subnet" "private_1" {
    vpc_id = "${aws_vpc.production.id}"
    cidr_block = "10.0.0.0/24"
    availability_zone = "${var.az1}"
    map_public_ip_on_launch = false

    tags {
        Name = "Private AZ 1"
    }
}

resource "aws_subnet" "private_2" {
    vpc_id = "${aws_vpc.production.id}"
    cidr_block = "10.0.1.0/24"
    availability_zone = "${var.az2}"
    map_public_ip_on_launch = false

    tags {
        Name = "Private AZ 2"
    }
}

resource "aws_subnet" "private_3" {
    vpc_id = "${aws_vpc.production.id}"
    cidr_block = "10.0.2.0/24"
    availability_zone = "${var.az3}"
    map_public_ip_on_launch = false

    tags {
        Name = "Private AZ 3"
    }
}


#Private subnets with static IPs
resource "aws_subnet" "private_1_static" {
    vpc_id = "${aws_vpc.production.id}"
    cidr_block = "10.0.5.0/24"
    availability_zone = "${var.az1}"
    map_public_ip_on_launch = false

    tags {
        Name = "Private AZ 1 static"
    }
}

resource "aws_subnet" "private_2_static" {
    vpc_id = "${aws_vpc.production.id}"
    cidr_block = "10.0.6.0/24"
    availability_zone = "${var.az2}"
    map_public_ip_on_launch = false

    tags {
        Name = "Private AZ 2 static"
    }
}

resource "aws_subnet" "private_3_static" {
    vpc_id = "${aws_vpc.production.id}"
    cidr_block = "10.0.7.0/24"
    availability_zone = "${var.az3}"
    map_public_ip_on_launch = false

    tags {
        Name = "Private AZ 3 static"
    }
}


#Public Subnets
resource "aws_subnet" "public_1" {
    vpc_id = "${aws_vpc.production.id}"
    cidr_block = "10.0.10.0/24"
    availability_zone = "${var.az1}"
    map_public_ip_on_launch = true

    tags {
        Name = "Public AZ 1"
    }
}

resource "aws_subnet" "public_2" {
    vpc_id = "${aws_vpc.production.id}"
    cidr_block = "10.0.11.0/24"
    availability_zone = "${var.az2}"
    map_public_ip_on_launch = true

    tags {
        Name = "Public AZ 2"
    }
}

resource "aws_subnet" "public_3" {
    vpc_id = "${aws_vpc.production.id}"
    cidr_block = "10.0.12.0/24"
    availability_zone = "${var.az3}"
    map_public_ip_on_launch = true

    tags {
        Name = "Public AZ 3"
    }
}


#Public Subnets with static IPs
resource "aws_subnet" "public_1_static" {
    vpc_id = "${aws_vpc.production.id}"
    cidr_block = "10.0.15.0/24"
    availability_zone = "${var.az1}"
    map_public_ip_on_launch = true

    tags {
        Name = "Public AZ 1 static"
    }
}

resource "aws_subnet" "public_2_static" {
    vpc_id = "${aws_vpc.production.id}"
    cidr_block = "10.0.16.0/24"
    availability_zone = "${var.az2}"
    map_public_ip_on_launch = true

    tags {
        Name = "Public AZ 2 static"
    }
}

resource "aws_subnet" "public_3_static" {
    vpc_id = "${aws_vpc.production.id}"
    cidr_block = "10.0.17.0/24"
    availability_zone = "${var.az3}"
    map_public_ip_on_launch = true

    tags {
        Name = "Public AZ 3 static"
    }
}


#Routing to internet for public networks
resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.production.id}"

    tags {
        Name = "default"
    }
}


resource "aws_route_table" "igw" {
  vpc_id = "${aws_vpc.production.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }

  tags {
      Name = "Internet gateway"
  }
}

resource "aws_route_table_association" "public_1" {
  subnet_id = "${aws_subnet.public_1.id}"
  route_table_id = "${aws_route_table.igw.id}"
}

resource "aws_route_table_association" "public_2" {
  subnet_id = "${aws_subnet.public_2.id}"
  route_table_id = "${aws_route_table.igw.id}"
}

resource "aws_route_table_association" "public_3" {
  subnet_id = "${aws_subnet.public_3.id}"
  route_table_id = "${aws_route_table.igw.id}"
}

resource "aws_route_table_association" "public_1_static" {
  subnet_id = "${aws_subnet.public_1_static.id}"
  route_table_id = "${aws_route_table.igw.id}"
}

resource "aws_route_table_association" "public_2_static" {
  subnet_id = "${aws_subnet.public_2_static.id}"
  route_table_id = "${aws_route_table.igw.id}"
}

resource "aws_route_table_association" "public_3_static" {
  subnet_id = "${aws_subnet.public_3_static.id}"
  route_table_id = "${aws_route_table.igw.id}"
}


#Routing to NAT instance AZ1 for private networks
resource "aws_route_table" "nat" {
  vpc_id = "${aws_vpc.production.id}"
  route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${aws_instance.nat.id}"
  }
  tags {
      Name = "NAT"
  }
}

resource "aws_route_table_association" "private_1" {
  subnet_id = "${aws_subnet.private_1.id}"
  route_table_id = "${aws_route_table.nat.id}"
}

resource "aws_route_table_association" "private_1_static" {
  subnet_id = "${aws_subnet.private_1_static.id}"
  route_table_id = "${aws_route_table.nat.id}"
}

resource "aws_route_table_association" "private_2" {
  subnet_id = "${aws_subnet.private_2.id}"
  route_table_id = "${aws_route_table.nat.id}"
}

resource "aws_route_table_association" "private_2_static" {
  subnet_id = "${aws_subnet.private_2_static.id}"
  route_table_id = "${aws_route_table.nat.id}"
}

resource "aws_route_table_association" "private_3" {
  subnet_id = "${aws_subnet.private_3.id}"
  route_table_id = "${aws_route_table.nat.id}"
}

resource "aws_route_table_association" "private_3_static" {
  subnet_id = "${aws_subnet.private_3_static.id}"
  route_table_id = "${aws_route_table.nat.id}"
}
