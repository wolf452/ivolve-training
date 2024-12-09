resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "main_vpc"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr

  tags = {
    Name = "main_subnet"
  }
}

resource "aws_security_group" "main" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "main_security_group"
  }
}

resource "aws_instance" "main" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main.id
  security_groups = [aws_security_group.main.id]

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "main_instance"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main_igw"
  }
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "main_route_table"
  }
}

resource "aws_route_table_association" "main" {
  subnet_id       = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}

resource "aws_sns_topic" "alarm_topic" {
  name = "EC2-Alarm-Topic"
}

resource "aws_sns_topic_subscription" "alarm_subscription" {
  topic_arn = aws_sns_topic.alarm_topic.arn
  protocol  = "email"
  endpoint  = var.sns_email
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_alarm" {
  alarm_name          = "EC2 CPU Utilization Alarm"
  alarm_description   = "Alarm if CPU utilization exceeds 70%"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  statistic           = "Average"
  period              = 60
  evaluation_periods  = 1
  threshold           = 70
  comparison_operator = "GreaterThanThreshold"
  dimensions = {
    InstanceId = aws_instance.main.id
  }

  alarm_actions = [aws_sns_topic.alarm_topic.arn]
}
