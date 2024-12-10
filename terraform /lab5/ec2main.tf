resource "aws_instance" "proxy" {
  count              = 2
  ami                = var.ami_id
  instance_type      = var.instance_type
  subnet_id          = element(var.subnet_ids, count.index)
  security_groups    = [var.security_group_id]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y nginx
              systemctl start nginx
              systemctl enable nginx
              echo "<h1>Proxy Instance ${count.index}</h1>" > /var/www/html/index.html

              cat <<EOF2 > /etc/nginx/sites-available/default
              server {
                  listen 80;
                  location / {
                      proxy_pass http://${var.second_lb_dns};
                      proxy_set_header Host \$host;
                      proxy_set_header X-Real-IP \$remote_addr;
                      proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
                  }
              }
              EOF2
              systemctl reload nginx
              EOF
}

resource "aws_instance" "backend" {
  count              = 2
  ami                = var.ami_id
  instance_type      = var.instance_type
  subnet_id          = element(var.subnet_ids, count.index + 2)
  security_groups    = [var.security_group_id]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y apache2
              systemctl start apache2
              systemctl enable apache2
              echo "<h1>Backend Instance ${count.index}</h1>" > /var/www/html/index.html
              EOF
}
