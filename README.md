1. Ensure the terraform state file is saved at an appropriate location.
2. It uses the current AWS region, which, unless specified, is the default region stored in AWS config file of the user running terraform.
3. Ensure that the user running ‘terraform apply’ command has permissions to create IAM role, policies and other resources like lambda function, SNS topic, SNS subscription, cloudwatch rule and cloudformation stack.
4. This terraform module uses 5 input variables: api_endpoint, app_key, bearer_token, subscribe_all, daily_event_rule. The api_endpoint, app_key and bearer_token need to be retrieved from the Cloudwatch integration created in BigPanda. subscribe_all and daily_event_rule accept boolean values and need to be set to “true” to create appropriate terraform resources.
