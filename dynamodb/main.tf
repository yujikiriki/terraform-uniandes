
# Northern Virginia
resource "aws_dynamodb_table" "virginia-dynamodb-table" {
  
  provider         = "aws.us-east-1"
  
  name             = "AmazonPoints"
  hash_key         = "UserId"
  range_key        = "Item"
  
  stream_enabled   = true
  stream_view_type = "NEW_IMAGE"
  read_capacity    = 20
  write_capacity   = 20
  
  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "Item"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled = false
  }

  global_secondary_index {
    name               = "ItemIndex"
    hash_key           = "UserId"
    range_key          = "Item"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "INCLUDE"
    non_key_attributes = ["UserId"]
  }

  tags {
    Name        = "dynamodb-table"
    Environment = "testing"
  }
}

# Oregon
resource "aws_dynamodb_table" "oregon-dynamodb-table" {
  
  provider         = "aws.us-west-2"
  
  name             = "AmazonPoints"
  hash_key         = "UserId"
  range_key        = "Item"
  
  stream_enabled   = true
  stream_view_type = "NEW_IMAGE"
  read_capacity    = 20
  write_capacity   = 20
  
  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "Item"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled = false
  }

  global_secondary_index {
    name               = "ItemIndex"
    hash_key           = "UserId"
    range_key          = "Item"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "INCLUDE"
    non_key_attributes = ["UserId"]
  }

  tags {
    Name        = "dynamodb-table"
    Environment = "testing"
  }
}

output "dynamo_db_stream" {
  value = "${aws_dynamodb_table.virginia-dynamodb-table.stream_arn}"
}

output "dynamo_db_table_arn" {
  value = "${aws_dynamodb_table.virginia-dynamodb-table.arn}"
}