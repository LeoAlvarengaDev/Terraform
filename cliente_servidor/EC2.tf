resource "null_resource" "provision_kafka" {
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install java-1.8.0-openjdk -y",
      "wget https://downloads.apache.org/kafka/3.5.0/kafka_2.13-3.5.0.tgz",
      "tar -xvf kafka_2.13-3.5.0.tgz",
      "sudo mv kafka_2.13-3.5.0 /opt/kafka",
      "sudo /opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties &"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("C:/Users/leona/.ssh/my-key.pem")
      host        = aws_instance.kafka.public_ip
    }
  }
}

resource "aws_instance" "api" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  key_name      = "my-key"
  security_groups = [aws_security_group.kafka_sg.name]

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install python3-pip -y
    pip3 install flask kafka-python
    echo '${file("api.py")}' > /home/ec2-user/app.py
    python3 /home/ec2-user/app.py &
  EOF

  tags = {
    Name = "API Gateway"
  }
}