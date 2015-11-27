provider "aws" {
  region = "eu-west-1"
}

variable "region" {
  default = "eu-west-1"
}

variable "az1" {
  default = "eu-west-1a"
}

variable "az2" {
  default = "eu-west-1b"
}

variable "az3" {
  default = "eu-west-1c"
}

#Ubuntu 14.04 AMI id (Image name:"ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-20150805")
variable "ubuntu_1404_amis" {
  default = {
    eu-west-1 = "ami-bc5101cb"
  }
}
