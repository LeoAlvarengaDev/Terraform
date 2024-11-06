variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "instance_ami" {
  type    = string
  default = "ami-06b21ccaeff8cd686"
}

variable "instance_tags" {
  type = map(string)
  default = {
    Name    = "Ubuntu"
    Project = "Terraform"
  }

}