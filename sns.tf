resource "aws_sns_topic" "sns_topic" {
  name = var.topic_name
}

resource "aws_sns_topic_subscription" "sns_subscription" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "https"
  endpoint  = "${var.api_endpoint}/cloudwatch/alerts?access_token=${var.bearer_token}&app_key=${var.app_key}"
}
