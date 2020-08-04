provider "aws" {
  region = "eu-west-2"
}

module "vpc" {
  source = "./vpc"

}
module "sg" {
  source = "./sg"
}

resource "aws_instance" "my_webserver" {
  ami           = "ami-00f6a0c18edb19300" #Ubuntu image
  instance_type = "t2.micro"

  vpc_security_group_ids = [module.sg.webserver_sg]
  subnet_id              = module.vpc.public_subnets
  // depends_on             = [module.vpc.public_subnets]
  tags = {
    Name    = "My_AWS_webs"
    owner   = "Yurii Bakhur"
    project = "Terraform Lesson2"
  }
}
