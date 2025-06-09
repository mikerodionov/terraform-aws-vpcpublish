variable "name" {
  description = "VPC Name."
  type        = string
}

variable "cidr_block" {
  default     = "10.0.42.0/24"
  description = "The CIDR block for the VPC."
  type        = string

  validation {
    condition     = provider::assert::cidrv4(var.cidr_block)
    error_message = "CIDR block must be valid /24"
  }
}

variable "subnets" {
  default = {
    public-1a = {
      cidr_block        = "10.0.42.0/26"
      availability_zone = "us-east-1a"
      public            = true
    }
    public-1b = {
      cidr_block        = "10.0.42.64/26"
      availability_zone = "us-east-1b"
      public            = true
    }
    public-1c = {
      cidr_block        = "10.0.42.128/26"
      availability_zone = "us-east-1c"
      public            = true
    }
  }
  description = "Subnets to create in the VPC."
  type = map(object({
    cidr_block        = string
    availability_zone = string
    public            = optional(bool, false)
  }))
  validation {
    condition = alltrue([
      for subnet in var.subnets : provider::assert::cidrv4(subnet.cidr_block)
    ])
    error_message = "Subnet CIDR blocks must all be valid IPv4 CIDR network adresses."
  }
}

variable "enable_igw" {
  default     = true
  description = "Enable the creation of an Internet Gateway."
  type        = bool
}
