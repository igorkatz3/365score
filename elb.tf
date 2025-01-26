# Application Load Balancer
resource "aws_lb" "elb" {
  name               = "dev-alb"
  load_balancer_type = "network"
  internal           = false
  security_groups    = [aws_security_group.sg.id]
  subnets            = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]
  tags = {
    Name = "dev-alb"
  }
}

#Listener + Listener rules
resource "aws_lb_listener" "listener_443" {
  load_balancer_arn = aws_lb.elb.arn
  port              = 443
  protocol          = "TCP"
  #ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  # Dynamically select certificate ARN based on region
  #certificate_arn   = var.cert
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg.arn

  }
  tags = {
    Name = "dev-alb-listener"
  }
}


resource "aws_lb_listener" "listener_80" {
  load_balancer_arn = aws_lb.elb.arn
  port              = 80
  protocol          = "TCP"
  # Dynamically select certificate ARN based on region
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg.arn

  }
  tags = {
    Name = "dev-alb-listener"
  }
}
# Create Target Group
resource "aws_lb_target_group" "tg" {
  name        = "dev-tg"
  port        = 80
  protocol    = "TCP"
  vpc_id      = aws_vpc.my_vpc.id
  target_type = "instance"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = "dev-tg"
  }
}




