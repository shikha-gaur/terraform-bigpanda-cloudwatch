# Output variable definitions

output "cloudformation_stack_name" {
  description = "Name (id) of cloudformation stack created in the process"
  value       = one(aws_cloudformation_stack.trigger_codebuild_stack[*].id)
}

output "event_rule_arn" {
  description = "ARN of the daily event rule"
  value       = one(aws_cloudwatch_event_rule.bigpanda_daily_rule[*].arn)
}

output "lambda_arn" {
  description = "ARN of the Lambda function"
  value       = one(aws_lambda_function.bigpanda_lambda[*].arn)
}

output "iam_policy_arn" {
  description = "ARN of the IAM policy"
  value       = aws_iam_policy.bigpanda_cloudwatch_lambda.arn
}

output "iam_role_arn" {
  description = "ARN of the IAM role"
  value       = one(aws_iam_role.bigpanda_role[*].arn)
}

output "sns_topic_arn" {
  description = "ARN of the SNS topic"
  value       = aws_sns_topic.sns_topic.arn
}

output "sns_subscription_arn" {
  description = "ARN of the SNS subscription"
  value       = aws_sns_topic_subscription.sns_subscription.arn
}