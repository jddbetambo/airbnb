variable "ami_id" {
  type        = string
  default     = "ami-06b21ccaeff8cd686"
  description = "instance ami used"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Instance type used"
}

# variable "Access_Key_ID" {
#   type        = string
#   description = "Your User Access Key ID for security and running ec2 commands"
# }

# variable "Access_Key_Secret" {
#   type        = string
#   description = "Your User Secret Access Key for security and running ec2 commands"
# }