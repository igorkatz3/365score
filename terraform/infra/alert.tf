resource "aws_cloudwatch_metric_alarm" "alert" {
  alarm_name          = "dev-alert"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "Number of healthy nodes in Target Group"
  actions_enabled     = "true"
#   alarm_actions       = ["arn:aws:sns:${var.region}:926788090244:support"]
#   ok_actions          = ["arn:aws:sns:${var.region}:926788090244:support"]
  dimensions = {
    TargetGroup  = aws_lb_target_group.tg.arn_suffix
    LoadBalancer = aws_lb.elb.arn_suffix
  }
}