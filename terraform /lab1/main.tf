terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# Data block to fetch existing VPC
data "aws_vpc" "ivolve" {
  tags = {
    Name = "ivolve"
  }
}

# Update the subnet blocks
resource "aws_subnet" "public" {
  vpc_id                  = data.aws_vpc.ivolve.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "ivolve-public-subnet"
    Environment = var.environment
  }
}

resource "aws_subnet" "private" {
  vpc_id            = data.aws_vpc.ivolve.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = "${var.region}b"

  tags = {
    Name        = "ivolve-private-subnet"
    Environment = var.environment
  }
}

# Create Security Group for EC2
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-security-group"
  description = "Security group for EC2 instance"
  vpc_id      = data.aws_vpc.ivolve.id

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
}

# Create Security Group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Security group for RDS instance"
  vpc_id      = data.aws_vpc.ivolve.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }
}

# Create EC2 Instance
resource "aws_instance" "app_server" {
  ami           = "ami-0e2c8caa4b6378d8c"  # Replace with desired AMI
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name        = "ivolve-app-server"
    Environment = var.environment
  }

  # Local provisioner to write EC2 IP to file
  provisioner "local-exec" {
    command = "echo ${self.public_ip} > ec2-ip.txt"
  }
}

# Create DB Subnet Group
resource "aws_db_subnet_group" "default" {
  name       = "ivolve-db-subnet-group"
  subnet_ids = [aws_subnet.private.id, aws_subnet.public.id]

  tags = {
    Name = "ivolve DB subnet group"
  }
}

# Create RDS Instance
resource "aws_db_instance" "database" {
  identifier           = "ivolve-database"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"   # Updated to a compatible MySQL version
  instance_class       = "db.t3.micro"  # Updated to a different DB instance class
  username             = "admin"
  password             = var.db_password
  skip_final_snapshot  = true

  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.default.name
}

# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = data.aws_vpc.ivolve.id

  tags = {
    Name = "ivolve-igw"
  }
}

# Create Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = data.aws_vpc.ivolve.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "ivolve-public-rt"
  }
}

# Associate Route Table with Public Subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}
