provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "kafka_sg" {
  name        = "kafka_sg"
  description = "Allow Kafka communication"

  ingress {
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_a" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  key_name      = "my-key"
  security_groups = [aws_security_group.kafka_sg.name]

  tags = {
    Name = "EC2 A - Cliente"
  }
  
}

resource "aws_instance" "ec2_b" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  key_name      = "my-key"
  security_groups = [aws_security_group.kafka_sg.name]

  tags = {
    Name = "EC2 B - Servidor"
  }
}

resource "aws_instance" "ec2_c" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  key_name      = "my-key"
  security_groups = [aws_security_group.kafka_sg.name]

  tags = {
    Name = "EC2 C - Servidor"
  }
}

resource "aws_instance" "ec2_d" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  key_name      = "my-key"
  security_groups = [aws_security_group.kafka_sg.name]

  tags = {
    Name = "EC2 D - Servidor"
  }
}

resource "aws_instance" "kafka" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  key_name      = "my-key"
  security_groups = [aws_security_group.kafka_sg.name]

  tags = {
    Name = "Kafka Broker"
  }
}