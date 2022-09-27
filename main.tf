data "archive_file" "handler_function_zip" {
  type        = "zip"
  source_dir  = "${path.root}${var.handler_path}"
  ouptut_path = "${path.module}/tmp/handler_function.zip"
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

  runtime = var.handler_runtime
  }

  tags = { 
    owner      = var.owner
    managed-by = "terraform"
  }
}

data "archive_file" "handler_function_zip" {
  type        = "zip"
  source_dir  = "${path.root}${var.handler_path}"
  ouptut_path = "${path.module}/tmp/handler_function.zip"
}

