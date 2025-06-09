# Default use case - relies only on defaults of the module
provider "aws" {}

variables {
  name = "vpc-test"
}

run "defaults" {
  command = plan

  assert {
    condition     = length(aws_subnet.subnets) == 3
    error_message = "The default subnet count is expected to be 3."
  }

  assert {
    condition     = length(aws_internet_gateway.igw) == 1
    error_message = "An Internet Gateway is expected to be deployed."
  }

  assert {
    condition     = length(aws_internet_gateway_attachment.igw_attach) == 1
    error_message = "An Internet Gateway attachment is expected to be created."
  }

  assert {
    condition     = length(aws_route_table.public) == 1
    error_message = "A public route table is expected to be created."
  }
# to account for negative tests - things that should fail and we are testing that they do
  expect_failures = [ 
    aws_route_table.public,
    var.cidr_block,
 ]
}