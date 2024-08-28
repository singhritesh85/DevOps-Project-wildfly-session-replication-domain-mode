data "aws_subnets" "subnet_nlb" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  filter {
    name   = "tag:Name"
    values = ["Public*"]
  }

}

output "nlb_subnet_id" {
  value = data.aws_subnets.subnet_nlb.ids
}

# Security Group for NLB
resource "aws_security_group" "appserver_nlb" {
  name        = "appserver-NLB"
  description = "Security Group for Network Server NLB"
  vpc_id      = var.vpc_id

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    protocol   = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port  = 80
    to_port    = 80
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "appserver-NLB-SG"
  }
}

#Network Loadbalancer
resource "aws_lb" "test-network-loadbalancer" {
  name               = var.network_loadbalancer_name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.appserver_nlb.id]           ###var.security_groups
  subnets            = data.aws_subnets.subnet_nlb.ids         ###var.subnets

  enable_deletion_protection = var.enable_deletion_protection
  idle_timeout = var.idle_timeout

  tags = {
    Environment = var.env
  }

}

#Target Group of Network Loadbalancer
resource "aws_lb_target_group" "target_group" {
  name     = var.target_group_name
  port     = var.instance_port      ##### Don't use protocol when target type is lambda
  protocol = var.instance_protocol  ##### Don't use protocol when target type is lambda
  vpc_id   = var.vpc_id
  target_type = var.target_type_nlb
###  load_balancing_algorithm_type = var.load_balancing_algorithm_type
  health_check {
    enabled = true ## Indicates whether health checks are enabled. Defaults to true.
    ###path = var.healthcheck_path     ###"/index.html"
    port = "traffic-port"
    protocol = "TCP"
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.timeout
    interval            = var.interval
  }
}

##Network Loadbalancer listener for TCP
resource "aws_lb_listener" "nlb_listener_front_end_TCP" {
  load_balancer_arn = aws_lb.test-network-loadbalancer.arn
  port              = "80"
  protocol          = "TCP"

   default_action {
    type             = var.type[0]
    target_group_arn = aws_lb_target_group.target_group.arn
  }

}

##Network Loadbalancer listener for TLS
resource "aws_lb_listener" "nlb_listener_front_end_TLS" {
  load_balancer_arn = aws_lb.test-network-loadbalancer.arn
  port              = "443"
  protocol          = "TLS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = var.type[0]
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

## EC2 Instance1 attachment to Target Group
resource "aws_lb_target_group_attachment" "ec2_instance1_attachment_to_tg" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = aws_instance.appserver[1].id               #var.ec2_instance_id[1]
  port             = var.instance_port
}

## EC2 Instance2 attachment to Target Group
resource "aws_lb_target_group_attachment" "ec2_instance2_attachment_to_tg" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = aws_instance.appserver[2].id          #var.ec2_instance_id[2]
  port             = var.instance_port
}
