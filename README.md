## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.11 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | ~> 2.2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.30.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.1.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | ~> 2.2.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.30.0 |
| <a name="provider_null"></a> [null](#provider\_null) | ~> 3.1.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.event_handler_lambda_iam_role](https://registry.terraform.io/providers/hashicorp/aws/4.30.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.event_handler_lambda_iam_role_policy](https://registry.terraform.io/providers/hashicorp/aws/4.30.0/docs/resources/iam_role_policy) | resource |
| [aws_lambda_event_source_mapping.lambda_sqs_mapping](https://registry.terraform.io/providers/hashicorp/aws/4.30.0/docs/resources/lambda_event_source_mapping) | resource |
| [aws_lambda_function.handler_lambda](https://registry.terraform.io/providers/hashicorp/aws/4.30.0/docs/resources/lambda_function) | resource |
| [aws_sqs_queue.event_sqs_queue](https://registry.terraform.io/providers/hashicorp/aws/4.30.0/docs/resources/sqs_queue) | resource |
| [null_resource.trigger](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [archive_file.handler_function_zip](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dead_letter_config"></a> [dead\_letter\_config](#input\_dead\_letter\_config) | n/a | <pre>object({<br>    target_arn = string<br>  })</pre> | `null` | no |
| <a name="input_handler_entrypoint"></a> [handler\_entrypoint](#input\_handler\_entrypoint) | Function entrypoint for the handler | `string` | n/a | yes |
| <a name="input_handler_path"></a> [handler\_path](#input\_handler\_path) | Path to the script to be run with lambda | `string` | n/a | yes |
| <a name="input_handler_runtime"></a> [handler\_runtime](#input\_handler\_runtime) | Runtime that the handler function utilizes. e.g. python37, node16, etc | `string` | n/a | yes |
| <a name="input_kms_master_key_id"></a> [kms\_master\_key\_id](#input\_kms\_master\_key\_id) | KMS key for encrypting SQS queue | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the service | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | Owner of the service | `string` | n/a | yes |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | List of security group IDs associated with the Lambda function. | `list(string)` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnet IDs associated with the lambda function | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_file_archive_path"></a> [file\_archive\_path](#output\_file\_archive\_path) | n/a |
| <a name="output_lambda_path"></a> [lambda\_path](#output\_lambda\_path) | n/a |
