resource "aws_route53_zone" "private" {
  name = "dev.com"
    vpc {
    vpc_id = aws_vpc.my_vpc.id
  }
}

#DNS Records
resource "aws_route53_record" "dev" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "dev.com"
  type    = "A"
  alias {
    name                   = aws_lb.elb.dns_name
    evaluate_target_health = true
    zone_id                = aws_lb.elb.zone_id
  }
}