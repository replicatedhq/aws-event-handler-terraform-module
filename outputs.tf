output "lambda_execution_role" {
  value = aws_iam_role.event_handler_lambda_iam_role.id
}
