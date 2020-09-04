Over the same infrastructure as Level 2, deploy a custom Jenkins image, based on Debian, inside Docker within an EC2 instance, hosted on a public subnet inside a VPC. 

**REQUIREMENTS**
* Install Tomcat 8 and deploy the jenkins.war file from https://www.jenkins.io/download/ on it.
* Store the image to ECR and deploy it.
* From the EC2 instance, access Jenkins and create a simple freestyle job.


**STEPS TO RUN**
  1. Download the jenkins.war from https://www.jenkins.io/download/ (the Generic Java package) and add it the project's root repository.

  2. Generate SSH private and public keys named `task1` on project's root repository.
  
  3. SSH from local machine to VPC with
  ```
  ssh -i <task1_path> ec2-user@<public IP from AWS console>
  ```
  
  4. Run the following commands to configure AWS and pull the docker image:
  ```
  # configure AWS
  aws configure set aws_access_key_id <aws_access_key_id>
  aws configure set aws_secret_access_key <aws_secret_access_key>
  aws configure set default.region <aws_region>
  aws --region <aws_region> ecr get-login --no-include-email --registry-ids <aws_account_id> | sh

  # To clone the Jenkins docker image, look for the ECR repository on the AWS console.
  docker pull <ecr_repository_url>:latest

  # first -p: port 80 exposed for localhost
  # second -p: port 50000 opened inside Jenkins container
  # repository_url: docker image
  # localjenkins: container name (new container based off of the docker image)
  docker run --name localjenkins -p 80:8080 -p 50000:50000 <ecr_repository_url>:latest
  ```

  5. To start the Jenkins container:
  ```
  docker start localjenkins
  ```

  6. Look for the EC2 instance on the AWS console and on any browser, and using the public IP: `X.X.X.X:80/jenkins` for the Jenkins interface.

**Other commands to know**
 
  To exit SSH mode:
  ```
  exit
  ```

  To stop a container:
  ```
  docker stop localjenkins
  ```

  To remove a container:
  ```
  docker rm localjenkins
  ```
