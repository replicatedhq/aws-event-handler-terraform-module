variable "name" {
  type        = string
  description = "Name of the service"
}

variable "owner" {
  type        = string
  description = "Owner of the service"
}

variable "handler_filepath" {
  type        = string
  description = "Path to the script to be run with lambda "
}

variable "handler_runtime" {
  type        = string
  description = "Runtime that the handler function utilizes. e.g. python37, node16, etc"
}

variable "handler_entrypoint" {
  type        = string
  description = "Function entrypoint for the handler"
}

variable "kms_master_key_id" {
  type        = string
  default     = ""
  description = "KMS key for encrypting SQS queue"
}

variable "vpc_config" {
  type = object({
    security_group_ids = list(string)
    subnet_ids         = list(string)
  })
  default = null
}

variable "dead_letter_config" {
  type = object({
    target_arn = string
  })
  default = null
}

variable "lambda_concurrent_executions" {
  type        = number
  default     = -1
  description = "Limit the number of concurrent executions of the lambda function. -1 removes any concurrency limitations"
}

variable "aws_provider_region" {
  type        = string
  description = "Region to deploy AWS resources to"
}
