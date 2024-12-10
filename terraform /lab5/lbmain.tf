resource "aws_lb" "lb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.subnet_ids
  enable_deletion_protection = false

  tags = {
    Name = var.lb_name
  }
}

resource "aws_lb_target_group" "target_group" {
  name     = "${var.lb_name}-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_lb_target_group_attachment" "target_group_attachment" {
  count            = length(var.backend_instance_ids)
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = var.backend_instance_ids[count.index]
}
