variable ami {
    type        = "string"
    description = "Use an existing Amazon Machine Image."
    default     = "ami-0603cbe34fd08cb81"
}

variable cidr_block {
    type        = "string"
    description = "IP addressing scheme for a port."
    default     = "0.0.0.0/0"
}

variable instance_type {
    type        = "string"
    description = "virtual server type in the cloud."
    default     = "t2.micro"
}

variable key_name {
    type        = "string"
    description = "Key name needed for SSH."
    default     = "ssh-key"
}

variable protocol {
    type        = "string"
    description = "Protocol for inbound rules."
    default     = "tcp"
}

variable security_group_name {
    type        = "string"
    description = "Name to identify security group."
    default     = "allow_ssh"
}

variable subnet_id {}

variable vpc_id {}