variable "name" {
  type        = string
  description = "Name of the service"
}

variable "owner" {
  type        = string
  description = "Owner of the service"
}

variable "handler_path" {
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

variable "handler_lambda_layers" {
  type        = list(any)
  default     = null
  description = "list of ARNs for layers to include with lambda function"
}

variable "lambda_timeout" {
  type        = number
  default     = 3
  description = "Amount of time your Lambda Function has to run in seconds"
}
