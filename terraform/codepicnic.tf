provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "aws-devpad-swarm-master" {
  ami           = "ami-2d39803a"
  instance_type = "t2.micro"
  security_groups = ["sg-33871c4b"]
  subnet_id = "subnet-5a9d2e70"
  key_name = "key_swarm"
}
