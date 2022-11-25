# pippiio aws-rds
Terraform module for deploying AWS RDS resources

## Usage
```hcl
module "rds" {
  source = "github.com/pippiio/aws-rds.git"

  config = {
    vpc_id     = "vpc-1234556qwer"
    subnet_ids = ["subnet-qwer1", "subnet-qwer2", "subnet-qwer3"]

    engine         = "postgres"
    engine_version = "14.2"

    db_name       = "aws-rds"
    instance_type = "db.t3.small"
    volume_size   = "20"
    multi_az      = true
  }
}
```

## Requirements
|Name     |Version |
|---------|--------|
|terraform|>= 1.2.0|
|aws      |~> 4.0  |


## Variables
### config:
|Name                  |Type       |Default            |Required|Description|
|----------------------|-----------|-------------------|--------|-----------|
|vpc_id                |string     |nil                |yes     |Id of VPC to deploy to|
|subnet_ids            |set(string)|nil                |yes     |Ids of subnets to deploy to|
|engine                |string     |mysql              |no      |Engine type of the database|
|engine_version        |string     |8.0                |no      |Engine version of the database|
|db_name               |string     |nil                |no      |Name of the database|
|port                  |number     |3306               |no      |Port of the database|
|instance_type         |string     |db.t3.small        |no      |Instance type of the database ec2|
|instance_name         |string     |db                 |no      |Name of the databse instance|
|volume_size           |number     |30                 |no      |Volume size of the database|
|multi_az              |bool       |false              |no      |Should the Database be multi zone avaliable|
|username              |string     |admin              |no      |Root username of the database|
|client_security_groups|set(string)|nil                |no      |Security group ID's for client|
|backup_window         |string     |nil                |no      |Backup window for Database|
|maintenance_window    |string     |nil                |no      |Maintaince window for Database|
|kms_key_id            |string     |nil                |no      |KMS key used for encryption at rest|


### name_prefix:
|Type        |Default|Required|Description|
|------------|-------|--------|-----------|
|string      |pippi- |no      |A prefix that will be used on all named resources|

### default_tags:
|Type        |Default|Required|Description|
|------------|-------|--------|-----------|
|map(string) |nil    |no      |A map of default tags, that will be applied to all resources applicable|

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.audit](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.error](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.general](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.slowquery](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_db_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_kms_alias.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_security_group.client](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ssm_parameter.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [random_password.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_config"></a> [config](#input\_config) | n/a | <pre>object({<br>    vpc_id                 = string<br>    subnet_ids             = set(string)<br>    engine                 = optional(string, "mysql")<br>    engine_version         = optional(string, "8.0")<br>    db_name                = optional(string, "db")<br>    port                   = optional(number, 3306)<br>    instance_type          = optional(string, "db.t3.small")<br>    instance_name          = optional(string, "db")<br>    volume_size            = optional(number, 30)<br>    multi_az               = optional(bool, false)<br>    replicate_source_db    = optional(string)<br>    username               = optional(string, "admin")<br>    client_security_groups = optional(set(string))<br>    backup_window          = optional(string, "01:30-02:59")<br>    maintenance_window     = optional(string, "Sat:03:00-Sat:04:00")<br>    kms_key_id             = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | A map of default tags, that will be applied to all resources applicable. | `map(string)` | `{}` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | A prefix that will be used on all named resources. | `string` | `"pippi-"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address"></a> [address](#output\_address) | n/a |
| <a name="output_client_security_group"></a> [client\_security\_group](#output\_client\_security\_group) | n/a |
| <a name="output_db_arn"></a> [db\_arn](#output\_db\_arn) | n/a |
| <a name="output_db_name"></a> [db\_name](#output\_db\_name) | n/a |
| <a name="output_password_ssm_key"></a> [password\_ssm\_key](#output\_password\_ssm\_key) | n/a |
| <a name="output_port"></a> [port](#output\_port) | n/a |
| <a name="output_username"></a> [username](#output\_username) | n/a |
<!-- END_TF_DOCS -->