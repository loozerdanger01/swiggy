provider "aws" {
   region = "ap-south-1"  
}

resource "aws_security_group" "my-ec2" {
  name        = "Jenkins-Security Group"
  description = "Open 22,443,80,9000,3000"

  # Define a single ingress rule to allow traffic on all specified ports
  ingress = [
    for port in [22, 80, 443, 9000, 3000] : {
      description      = "TLS from VPC"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-ec2"
  }
}


resource "aws_instance" "web" {
  ami                    = "ami-0f58b397bc5c1f2e8" # change your ami name 
  instance_type          = "t2.medium"
  key_name               = "NITHI"
  vpc_security_group_ids = [aws_security_group.my-ec2.id]
  user_data              = templatefile("./script.sh", {})

  tags = {
    Name = "swiggy-base-server"
  }
  root_block_device {
    volume_size = 30
  }
}
