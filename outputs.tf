output "file_archive_path" {
  value = abspath(data.archive_file.handler_function_zip.output_path)
}

output "lambda_path" {
  value = abspath(aws_lambda_function.handler_lambda.filename)
}
