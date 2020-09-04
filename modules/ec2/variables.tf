variable ami {
    type        = "string"
    description = "Use an existing Amazon Machine Image."
    default     = "ami-0603cbe34fd08cb81"
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

variable subnet_id {}

variable vpc_id {}
