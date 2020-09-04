#!/bin/bash

# in case of setlocale: LC_CTYPE: cannot change locale (UTF-8): No such file or directory.
echo "LANG=en_US.utf-8" | sudo tee -a /etc/environment
echo "LC_ALL=en_US.utf-8" | sudo tee -a /etc/environment

yum update -y
# install Docker
yum install -y docker
service docker start
# include the ec2-user on the Docker set
usermod -a -G docker ec2-user