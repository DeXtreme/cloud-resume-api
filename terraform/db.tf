resource "aws_dynamodb_table" "resumes" {
  name           = "Resumes"
  billing_mode   = "PROVISIONED"
  read_capacity  = 2
  write_capacity = 2
  hash_key       = "version"

  attribute {
    name = "version"
    type = "S"
  }

  tags = {
    Name = "dynamodb-table-resumes"
  }
}
