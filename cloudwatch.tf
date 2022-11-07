resource "aws_cloudwatch_metric_alarm" "Greenalytics_cpu_alarm_down" {
  alarm_name = "${var.cpu_alarm_down}"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "10"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.Greenalytics.name
  }

  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions = [ aws_autoscaling_policy.Greenalytics_policy_down.arn ]
}

