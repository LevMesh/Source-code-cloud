terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.16"
        }
    }
    required_version = ">= 1.2.0"
}

provider "aws" {
    region  = "us-east-2"
}

resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins_sg"
  description = "Security group for Jenkins"

    ingress {
      from_port   = 8080
      to_port     = 8080
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
      description      = "Allow ssh"
      from_port        = 22
      to_port          = 22
      protocol         = "TCP"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

}

resource "aws_instance" "jenkins" {
  ami           = "ami-0a606d8395a538502"
  instance_type = "t2.micro"
  key_name = "my_key"
  user_data = "${file("install_jenkins_docker.sh")}"
  security_groups = [aws_security_group.jenkins_sg.name]

  root_block_device {
    volume_size = 30 # in GB <<----- I increased this!
    volume_type = "gp2"
  }
}

output "jenkins_url" {
  value = "http://${aws_instance.jenkins.public_ip}:8080" 
}



