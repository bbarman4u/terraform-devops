
module "core_infra_network" {
  source = "../vpc-module" # Mandatory
}

####################
# Create Application Load Balancer's default Target Group
####################
resource "aws_lb_target_group" "default_tg" {
  name        = "default-back-end-service-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.core_infra_network.vpc_id #local.vpc_id #TODO

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 30
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
  }
}

####################
# Create Each Back End Services Target Groups
####################
resource "aws_lb_target_group" "back_end_services_tgs" {
  for_each    = local.target_group_config
  name        = each.key
  port        = each.value.port
  protocol    = each.value.protocol
  target_type = each.value.target_type
  vpc_id      = module.core_infra_network.vpc_id #local.vpc_id # TODO

  health_check {
    healthy_threshold   = each.value.health_check.healthy_threshold
    unhealthy_threshold = each.value.health_check.unhealthy_threshold
    interval            = each.value.health_check.interval
    path                = each.value.health_check.path
    port                = each.value.health_check.port
    protocol            = each.value.health_check.protocol
    matcher             = each.value.health_check.matcher
    timeout             = each.value.health_check.timeout
  }
}

####################
# Create Application Load Balancer
####################
resource "aws_lb" "back_end_services_alb" {
  name                       = "back-end-services-alb"
  internal                   = true
  load_balancer_type         = "application"
  security_groups            = [module.alb_sg.security_group_id]
  subnets                    = module.core_infra_network.private_subnets
  enable_deletion_protection = false
}

####################
# Create Listener for Application Load Balancer with default action which needs a TG
####################
resource "aws_alb_listener" "back_end_services_alb_http_listener" {
  load_balancer_arn = aws_lb.back_end_services_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.default_tg.arn
  }
  depends_on = [
    aws_lb_target_group.default_tg
  ]
}

resource "aws_alb_listener_rule" "forward_to_respective_tg" {
  for_each     = local.target_group_config
  listener_arn = aws_alb_listener.back_end_services_alb_http_listener.arn
  priority     = each.value.listener_rules.priority

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.back_end_services_tgs[each.key].arn
  }

  condition {
    path_pattern {
      values = [each.value.listener_rules.path_pattern]
    }
  }
  depends_on = [
    aws_alb_listener.back_end_services_alb_http_listener,
    aws_lb_target_group.default_tg
  ]
}