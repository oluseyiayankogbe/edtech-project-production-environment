#Create Route53 A record to link domain name to application load balancer (Alias record)
resource "aws_route53_record" "route53-record-dns" {
  zone_id = data.aws_route53_zone.route-53-zone.zone_id
  name    = "${data.aws_route53_zone.route-53-zone.name}"
  type    = "A"
  

    alias {
    name                   = aws_lb.load-balancer.dns_name
    zone_id                = aws_lb.load-balancer.zone_id
    evaluate_target_health = true
  }
}
