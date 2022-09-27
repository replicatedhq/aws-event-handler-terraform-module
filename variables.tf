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

