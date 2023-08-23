# create a https listener on port 443 with forward action
resource "aws_lb_listener" "alb-https-listener" {
  load_balancer_arn  = aws_lb.load-balancer.arn
  port               = 443
  protocol           = "HTTPS"
  ssl_policy         = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn    = data.aws_acm_certificate.amazon_issued.arn
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb-target-group.arn
  }

}

# create a http listener on port 80 with redirect action
resource "aws_lb_listener" "alb-http-listener" {
  load_balancer_arn  = aws_lb.load-balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }

  }
}