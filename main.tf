# Resource for archive_file to depend on to force archiving during applies
resource "null_resource" "trigger" {
  triggers = {
    timestamp = timestamp()
  }
}

data "archive_file" "handler_function_zip" {
  type        = "zip"
  source_dir  = var.handler_path
  output_path = "${path.root}/handler_function.zip"

  depends_on = [resource.null_resource.trigger]
}



resource "aws_iam_role" "event_handler_lambda_iam_role" {
  name = "event_handler_lambda_iam_role-${var.name}"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Effect" : "Allow",
        "Sid" : ""
      }
    ]
  })

  depends_on = [resource.aws_sqs_queue.event_sqs_queue]
}

resource "aws_iam_role_policy" "event_handler_lambda_iam_role_policy" {
  name = "event_handler_lambda_iam_role_policy-${var.name}"
  role = aws_iam_role.event_handler_lambda_iam_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : "lambda:InvokeFunction",
        "Resource" : aws_lambda_function.handler_lambda.arn
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "logs:PutLogEvents",
          "logs:CreateLogStream",
          "logs:CreateLogGroup"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "sqs:*"
        ],
        "Resource" : aws_sqs_queue.event_sqs_queue.arn
      }
    ]
  })

  depends_on = [resource.aws_lambda_function.handler_lambda, resource.aws_sqs_queue.event_sqs_queue]
}

resource "aws_lambda_function" "handler_lambda" {
  filename      = "${path.root}/handler_function.zip"
  function_name = "handler_lambda-${var.name}"
  role          = aws_iam_role.event_handler_lambda_iam_role.arn
  handler       = var.handler_entrypoint

  source_code_hash = data.archive_file.handler_function_zip.output_base64sha256

  runtime                        = var.handler_runtime
  reserved_concurrent_executions = var.lambda_concurrent_executions

  tracing_config {
    mode = "Active"
  }

  dynamic "dead_letter_config" {
    for_each = var.dead_letter_config == null ? [] : [var.dead_letter_config]

    content {
      target_arn = dead_letter_config.value.target_arn
    }
  }

  dynamic "vpc_config" {
    for_each = var.vpc_config == null ? [] : [var.vpc_config]

    content {
      subnet_ids         = vpc_config.value.subnet_ids
      security_group_ids = vpc_config.value.security_group_ids
    }
  }

  tags = {
    owner      = var.owner
    managed-by = "terraform"
  }
}

resource "aws_sqs_queue" "event_sqs_queue" {
  name = "event-handler-${var.name}"

  kms_master_key_id = var.kms_master_key_id == "" ? null : var.kms_master_key_id

  tags = {
    owner      = var.owner
    managed-by = "terraform"
  }
}

resource "aws_lambda_event_source_mapping" "lambda_sqs_mapping" {
  event_source_arn = aws_sqs_queue.event_sqs_queue.arn
  function_name    = aws_lambda_function.handler_lambda.arn

  depends_on = [resource.aws_lambda_function.handler_lambda]
}
