resource "aws_autoscaling_group" "loadbalancer" {
  availability_zones = ["${var.az1}","${var.az2}","${var.az3}"]
  vpc_zone_identifier = ["${aws_subnet.private_1.id}","${aws_subnet.private_2.id}","${aws_subnet.private_3.id}"]
  name = "Loadbalancer"
  min_size = 1
  desired_capacity=1
  max_size = 5
  launch_configuration = "${aws_launch_configuration.loadbalancer.id}"
  load_balancers = ["${aws_elb.elb.name}"]

  tag {
    key = "Name"
    value = "Loadbalancer"
    propagate_at_launch = true
  }
}


resource "aws_launch_configuration" "loadbalancer" {
  name = "Loadbalancer"
  image_id = "${lookup(var.ubuntu_1404_amis, var.region)}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.aws_meetup.key_name}"
  user_data = "${file(\"../provision/loadbalancer/cloud-config\")}"
  security_groups = ["${aws_security_group.vpc.id}"]
}

resource "aws_elb" "elb" {
  name = "elb"
  subnets = ["${aws_subnet.public_1.id}","${aws_subnet.public_2.id}","${aws_subnet.public_3.id}"]
  security_groups = ["${aws_security_group.vpc.id}","${aws_security_group.http.id}"]
  connection_draining = true
  connection_draining_timeout = 300

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 10
    timeout = 5
    target = "TCP:80"
    interval = 10
  }

  tags {
    Name = "Elastic load balancer"
  }
}
