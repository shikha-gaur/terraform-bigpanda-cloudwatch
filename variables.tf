variable "topic_name" {
  type        = string
  default     = "BigPanda_Topic"
  description = "Enter a name for the topic. Default is 'BigPanda_Topic'"
}

variable "api_endpoint" {
  type = string
  description = "Enter the BigPanda base API URL as displayed in integration instructions in BigPanda"
}

variable "bearer_token" {
  type = string
  validation {
    condition     = can(regex("[0-9]+", var.bearer_token))
    error_message = "Invalid Bearer Token."
  }
  description = "Enter your BigPanda Bearer Token"
}

variable "app_key" {
  type = string
  validation {
    condition     = can(regex("[0-9]+", var.app_key))
    error_message = "Invalid App Key."
  }
  description = "Enter a CloudWatch App Key from your BigPanda Console"
}

variable "subscribe_all" {
  type        = bool
  description = "Setting this to 'true' will automatically add the BigPanda Topic to all existing CloudWatch Alarms"
}

variable "daily_event_rule" {
  type        = bool
  description = "Setting this to 'true' will create a CloudWatch Event to run the BigPanda SubscribeAll Lambda once a day"
}

locals {
  bigpanda_daily_rule_name = one(aws_cloudwatch_event_rule.bigpanda_daily_rule[*].name)
  bigpanda_daily_rule_arn  = one(aws_cloudwatch_event_rule.bigpanda_daily_rule[*].arn)
}

locals {
  bigpanda_role_name = one(aws_iam_role.bigpanda_role[*].name)
  bigpanda_role_arn  = one(aws_iam_role.bigpanda_role[*].arn)
}

data "aws_region" "current" {}