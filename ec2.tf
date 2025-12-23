# Key pair (login)
resource "aws_key_pair" "my_key" {
    key_name = "terra-key"
    public_key = file("terra-key.pub")
}

# VPC & Security group
resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "my_security_group" {
    name = "terra-sg"
    description = "This will add a Terraform generated security group"
    vpc_id = aws_default_vpc.default.id    # Interpolation

    # Inbound rules
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH open"
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP open"
    }

    # Outbound rules
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Outbound traffic open"
    }

    tags = {
        Name = "automate-sg"
    }
}

    
# EC2 instance
resource "aws_instance" "my_instance" {
    key_name = aws_key_pair.my_key.key_name
    security_groups = [aws_security_group.my_security_group.name]
    instance_type = var.aws_instance_type
    ami = var.aws_ami_id   # AMI = Ubuntu
    user_data = file("install_nginx.sh")

    root_block_device {
        volume_size = var.aws_root_storage_size
        volume_type = "gp3"
    }

    tags = {
        Name = "My-automated-instance"
    }
}