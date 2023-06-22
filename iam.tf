resource "aws_iam_role" "bigpanda_role" {
  count = var.daily_event_rule ? 1 : 0
  name  = "BigPandaCloudWatchLambda-${data.aws_region.current.name}"
  assume_role_policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [
      {
        "Effect" = "Allow",
        "Principal" = {
          "Service" = [
            "lambda.amazonaws.com"
          ]
        },
        "Action" = [
          "sts:AssumeRole"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "basic_access_bigpanda_role_attach" {
  count       = var.daily_event_rule ? 1 : 0
  role        = local.bigpanda_role_name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "aws_iam_policy_document" "bigpanda_cloudwatch_lambda" {
  statement {
    sid    = "AllowBigPandaLambdaToListAlarms"
    effect = "Allow"
    actions = [
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:DescribeAlarms"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "bigpanda_cloudwatch_lambda" {
  name   = "BigPandaCloudWatchLambda"
  policy = data.aws_iam_policy_document.bigpanda_cloudwatch_lambda.json
}

resource "aws_iam_role_policy_attachment" "bigpanda-cloudwatch-lambda-policy-attachment" {
  count      = var.daily_event_rule ? 1 : 0
  role       = local.bigpanda_role_name
  policy_arn = aws_iam_policy.bigpanda_cloudwatch_lambda.arn
}
