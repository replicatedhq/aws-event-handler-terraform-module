data "archive_file" "handler_function_zip" {
  type        = "zip"
  source_dir  = "${path.root}${var.handler_path}"
  output_path = "${path.module}/tmp/handler_function.zip"
}

resource "aws_iam_role" "event_handler_lambda_iam_role" {
  name = "event_handler_lambda_iam_role-${var.name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "handler_lambda" {
  filename      = "handler_function.zip"
  function_name = "handler_lambda-${var.name}"
  role          = aws_iam_role.event_handler_lambda_iam_role.arn
  handler       = var.handler_entrypoint

  source_code_hash = filebase64sha256("${path.module}/tmp/handler_function.zip")

  runtime                        = var.handler_runtime
  reserved_concurrent_executions = 0

  tracing_config {
    mode = "Active"
  }

  dead_letter_config {
    target_arn = var.dead_letter_queue_arn == "" ? null : var.dead_letter_queue_arn
  }

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

  tags = {
    owner      = var.owner
    managed-by = "terraform"
  }
}

resource "aws_sqs_queue" "event-sqs-queue" {
  name = "event-handler-${var.name}"

  kms_master_key_id = var.kms_master_key_id == "" ? null : var.kms_master_key_id

  tags = {
    owner      = var.owner
    managed-by = "terraform"
  }
}
