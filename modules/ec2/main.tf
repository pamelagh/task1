# Add ingress rule to allow SSH from local machine to EC2 instance
resource "aws_security_group" "allow_ssh" {
  name        = "${var.security_group_name}"
  description = "Traffic rules."
  vpc_id = "${var.vpc_id}"

  ingress {
    description = "Allow SSH from local machine to EC2."
    from_port   = 22
    to_port     = 22
    protocol    = "${var.protocol}"
    cidr_blocks = ["${var.cidr_block}"]
  }

  ingress {
    description = "Access port 80 from anywhere."
    from_port   = 80
    to_port     = 80
    protocol    = "${var.protocol}"
    cidr_blocks = ["${var.cidr_block}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.cidr_block}"]
  }

  tags = {
    Name = "${var.security_group_name}"
  }
}

# Add keys
resource "aws_key_pair" "ssh-key" {
  key_name   = "${var.key_name}"
  public_key = "${file("task1.pub")}"
}

# EC2 instance that references VPC, security group and keys
resource "aws_instance" "default" {
  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  subnet_id              = "${var.subnet_id}"
  associate_public_ip_address = true
  key_name               = "${var.key_name}"
  user_data = "${file("steps.sh")}"
}
