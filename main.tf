
resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type

  /*### Mandatory from checkov ###*/
  monitoring = true  
  ebs_optimized = true

  root_block_device {
    encrypted     = true
  }

  // Ec2 instance name to display
  tags = {
    Name = "airbnb-web-server"
  }
}

