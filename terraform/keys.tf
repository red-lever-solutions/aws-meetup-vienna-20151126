resource "aws_key_pair" "aws_meetup" {
  key_name = "aws_meetup"
  public_key = "${file(\"~/.ssh/aws_meetup_rsa.pub\")}"
}
