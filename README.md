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

### name_prefix:
|Type        |Default|Required|Description|
|------------|-------|--------|-----------|
|string      |pippi- |no      |A prefix that will be used on all named resources|

### default_tags:
|Type        |Default|Required|Description|
|------------|-------|--------|-----------|
|map(string) |nil    |no      |A map of default tags, that will be applied to all resources applicable|
