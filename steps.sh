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

# clone the Jenkins docker image
docker pull jenkins/jenkins

# create a volume on local machine and map it to the Jenkins directory in the container in other to save data
docker volume create jenkins-data

# first -p: port 80 exposed for localhost
# second -p: port 50000 opened inside Jenkins container
# jenkins: docker image name
# localjenkins: container name (new container based off of the Jenkins image)
docker run --name localjenkins -p 80:8080 -p 50000:50000 -v jenkins-data:/var/jenkins_home jenkins
