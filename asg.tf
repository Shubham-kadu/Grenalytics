resource "aws_autoscaling_group" "Greenalytics" {
   name = "${aws_launch_configuration.Greenalytics.name}-asg"

  min_size             = 1
  desired_capacity     = 2
  max_size             = 4

  health_check_type    = "ELB"
  load_balancers = [
    aws_elb.Greenalytics_elb.id
  ]

  launch_configuration = aws_launch_configuration.Greenalytics.name

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity = "1Minute"

  vpc_zone_identifier  = [
    aws_subnet.public_ap_south_1a.id,
    aws_subnet.public_ap_south_1b.id
  ]

  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "web"
    propagate_at_launch = true
  }

}

resource "aws_autoscaling_policy" "Greenalytics_policy_up" {
  name = "${var.Greenalytics_policy_up}"
  scaling_adjustment = 1
  adjustment_type = "ChangeInCapacity"
  cooldown = 300
  autoscaling_group_name = aws_autoscaling_group.Greenalytics.name
}
resource "aws_cloudwatch_metric_alarm" "cpu_alarm_up" {
  alarm_name = "${var.cpu_alarm_up}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "60"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.Greenalytics.name
  }

  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions = [ aws_autoscaling_policy.Greenalytics_policy_up.arn ]
}

resource "aws_autoscaling_policy" "Greenalytics_policy_down" {
  name = "${var.Greenalytics_policy_down}"
  scaling_adjustment = -1
  adjustment_type = "ChangeInCapacity"
  cooldown = 300
  autoscaling_group_name = aws_autoscaling_group.Greenalytics.name
}


