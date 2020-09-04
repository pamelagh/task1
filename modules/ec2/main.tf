# Add ingress rule to allow SSH from local machine to EC2 instance
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Traffic rules."
  vpc_id = "${var.vpc_id}"

  ingress {
    description = "Allow SSH from local machine to EC2."
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
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
}
