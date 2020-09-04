Over the same infrastructure, deploy a Nginx docker container inside the EC2 instance and test access to the internet using the 80 port.
Use the container from Docker hub.

**STEPS TO RUN**
  1. SSH from local machine to VPC with
  ```
  ssh -i <task1 path> ec2-user@<public IP from AWS console>
  ```

  2. Can test that the web server is serving a page.
  ```
  curl localhost
  ```

  3. Look for the EC2 instance on the AWS console and on any browser, go to the public DNS.
  For example, http://ec2-X-X-X-X.us-XXXX-X.compute.amazonaws.com
