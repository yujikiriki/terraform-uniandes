provider aws {
  version = "~> 1.11"

  alias   = "us-east-1"
  region  = "us-east-1"

  #access_key = "[YOUR AWS ACCESS KEY]"
  #secret_key = "[YOUR AWS SECRET KEY]"
}

provider "aws" {
  version = "~> 1.11"
  
  alias  = "us-west-2"
  region = "us-west-2"

  #access_key = "[YOUR AWS ACCESS KEY]"
  #secret_key = "[YOUR AWS SECRET KEY]"
}

provider template {
  version = "~> 1.0"
}

provider "archive" {
  version = "~> 1.0"
}

module "dynamodb" {
  source = "./dynamodb"
}

module "iam_role" {
  source = "./iam_role"
}

module "lambda" {
  source = "./lambda"
  lambda_role = "${module.iam_role.lambda_role}"
  dynamo_db_stream = "${module.dynamodb.dynamo_db_stream}"
  dynamo_db_table_arn = "${module.dynamodb.dynamo_db_table_arn}"
}
