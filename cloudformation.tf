resource "aws_cloudformation_stack" "trigger_codebuild_stack" {
  count = var.subscribe_all && daily_event_rule ? 1 : 0
  name = "trigger-codebuild-stack"
  parameters = {
    BigPandaLambdaFunctionArn = aws_lambda_function.bigpanda_lambda[0].arn
    SubscribeAll              = var.subscribe_all
  }

  template_body = <<STACK
{
  "AWSTemplateFormatVersion": "2010-09-09",
  "Parameters" : {
    "SubscribeAll" : {
      "Type" : "String",
      "Description" : "Setting this to 'true' will automatically add the BigPanda Topic to all existing CloudWatch Alarms"
    },
    "BigPandaLambdaFunctionArn" : {
      "Type" : "String"
    }
  },
  "Conditions": {
    "SubscribeToAlarms": {
      "Fn::Equals": [
        {
          "Ref": "SubscribeAll"
        },
        "true"
      ]
    }
  },
  "Resources" : {
    "BigPandaInvokeLambda": {
      "Type" : "AWS::CloudFormation::CustomResource",
      "Properties" : {
        "ServiceToken" : {
          "Ref" : "BigPandaLambdaFunctionArn"
        }
      },
      "Condition": "SubscribeToAlarms"
    }
  }
}
STACK
}