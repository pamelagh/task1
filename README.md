**LEVEL 1**
Create VPC and EC2 instance with terraform. Test SSH functionality from local machine to EC2 using the port 22.

VPC must have 2 public and 2 private subnets.

**LEVEL 2**
Over the same infrastructure, deploy a Nginx docker container inside the EC2 instance and test access to the internet using the 80 port. Use the container from Docker hub.

**LEVEL 3**
Over the same infrastructure as Level 2, deploy a Jenkins container (from Docker hub) inside Docker within an EC2 instance, hosted on a public subnet inside a VPC. Create a simple freestyle job.

**LEVEL 4**
Over the same infrastructure as Level 2, deploy a custom Jenkins image, based on Debian, inside Docker within an EC2 instance, hosted on a public subnet inside a VPC. Install Tomcat 8 on the Dockerfile and deploy the jenkins.war file on it.