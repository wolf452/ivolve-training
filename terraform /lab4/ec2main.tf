resource "aws_instance" "web" {
  ami           = "ami-0e2c8caa4b6378d8c" 
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  associate_public_ip_address = true 

  user_data = <<-EOT
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y nginx
              echo "<h1>Welcome to Nginx on $(hostname -f)</h1>" > /var/www/html/index.html
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOT

  tags = {
    Name = var.instance_name
  }
}
