resource "aws_cloudwatch_event_rule" "bigpanda_daily_rule" {
  count               = var.daily_event_rule == true ? 1 : 0
  name                = "bigpanda_daily_rule"
  description         = "Invokes the BigPanda-CloudWatch-Lambda every day"
  schedule_expression = "rate(1 day)"
}

resource "aws_cloudwatch_event_target" "lambda" {
  count     = var.daily_event_rule == true ? 1 : 0
  rule      = local.bigpanda_daily_rule_name
  target_id = aws_lambda_function.bigpanda_lambda[0].function_name
  arn       = aws_lambda_function.bigpanda_lambda[0].arn
}