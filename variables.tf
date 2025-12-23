variable "aws_instance_type" {
    default = "t3.small"
    type = string
}

variable "aws_root_storage_size" {
    default = 15
    type = number
}

variable "aws_ami_id" {
    default = "ami-0f5fcdfbd140e4ab7"
    type = string
}