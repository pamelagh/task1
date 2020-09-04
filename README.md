Over the same infrastructure as Level 2,, deploy a Jenkins container (from Docker hub) inside Docker within an EC2 instance, hosted on a public subnet inside a VPC.
Create a simple freestyle job.

**STEPS TO RUN**
  1. SSH from local machine to VPC with
  ```
  ssh -i <task1 path> ec2-user@<public IP from AWS console>
  ```
  
  Example: `ssh -i /Users/pamela/Documents/task1/task1 ec2-user@X.X.X.X`

  2. To start the Jenkins container:
  ```
  docker start localjenkins //container_id
  ```
  
  3. To get the initial admin password:
  ```
  docker exec localjenkins bash -c 'cat $JENKINS_HOME/secrets/initialAdminPassword'
  ```

  4. Look for the EC2 instance on the AWS console and on any browser, and using the public IP: `X.X.X.X:80` for the Jenkins interface.

**Other commands to know**
  
  To exit SSH mode:
  ```
  exit
  ```

  To list jenkins image:
  ```
  docker image ls jenkins
  ```

  To stop a container:
  ```
  docker stop localjenkins //container_id
  ```

  To remove a container:
  ```
  docker rm localjenkins //container_id
  ```