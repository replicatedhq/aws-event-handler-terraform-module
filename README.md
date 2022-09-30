## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0.11 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | ~> 2.2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.30.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | ~> 2.2.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.30.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.event_handler_lambda_iam_role](https://registry.terraform.io/providers/hashicorp/aws/4.30.0/docs/resources/iam_role) | resource |
| [aws_lambda_function.handler_lambda](https://registry.terraform.io/providers/hashicorp/aws/4.30.0/docs/resources/lambda_function) | resource |
| [aws_sqs_queue.event-sqs-queue](https://registry.terraform.io/providers/hashicorp/aws/4.30.0/docs/resources/sqs_queue) | resource |
| [archive_file.handler_function_zip](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dead_letter_queue_arn"></a> [dead\_letter\_queue\_arn](#input\_dead\_letter\_queue\_arn) | Dead letter queue for events that failed to process from the lambda function | `string` | `""` | no |
| <a name="input_handler_entrypoint"></a> [handler\_entrypoint](#input\_handler\_entrypoint) | Function entrypoint for the handler | `string` | n/a | yes |
| <a name="input_handler_path"></a> [handler\_path](#input\_handler\_path) | Path to the script to be run with lambda | `string` | n/a | yes |
| <a name="input_handler_runtime"></a> [handler\_runtime](#input\_handler\_runtime) | Runtime that the handler function utilizes. e.g. python37, node16, etc | `string` | n/a | yes |
| <a name="input_kms_master_key_id"></a> [kms\_master\_key\_id](#input\_kms\_master\_key\_id) | KMS key for encrypting SQS queue | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the service | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | Owner of the service | `string` | n/a | yes |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | List of security group IDs associated with the Lambda function. | `list(string)` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnet IDs associated with the lambda function | `list(string)` | n/a | yes |

## Outputs

No outputs.
