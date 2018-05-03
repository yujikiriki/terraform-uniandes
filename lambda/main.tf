resource "aws_lambda_function" "dynamodb_replication_lambda" {
  
  filename         = "./resources/project/target/lambda-0.1.0-SNAPSHOT.jar"
  function_name    = "dymabodb_table_replicator"
  role             = "${var.lambda_role}"
  handler          = "com.s4n.lambda.HelloLambdaHandler"
  source_code_hash = "${base64sha256(file("./resources/project/target/lambda-0.1.0-SNAPSHOT.jar"))}"
  runtime          = "java8"
  memory_size      =  256
  timeout          =  20
}

resource "aws_cloudwatch_log_group" "log_group" {
  name = "/aws/lambda/dymabodb_table_replicator"
}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  batch_size        = 1
  event_source_arn  = "${var.dynamo_db_stream}"
  enabled           = true
  function_name     = "${aws_lambda_function.dynamodb_replication_lambda.arn}"
  starting_position = "LATEST"
}


resource "aws_lambda_permission" "enables_call_from_dynamo" {
  statement_id  = "AllowExecutionFromDynamoDB"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.dynamodb_replication_lambda.function_name}"
  principal     = "dynamodb.amazonaws.com"
  source_arn    = "${var.dynamo_db_stream}"
}