provider "aws" {}

variables {
  name       = "vpc-test"
  enable_igw = false
}

run "no_igw" {
  command = plan

  assert {
    condition     = length(aws_subnet.subnets) == 3
    error_message = "The default subnet count is expected to be 3."
  }

  assert {
    condition     = length(aws_internet_gateway.igw) == 0
    error_message = "No Internet Gateway is expected to be deployed when enable_igw is false."
  }

  assert {
    condition     = length(aws_internet_gateway_attachment.igw_attach) == 0
    error_message = "An Internet Gateway attachment is expected to be created when enable_igw is false."
  }

  assert {
    condition     = length(aws_route_table.public) == 0
    error_message = "A public route table is expected to be created when enable_igw is false."
  }
}