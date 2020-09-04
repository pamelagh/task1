Create VPC and EC2 instance with terraform. Test SSH functionality from local machine to EC2 using the port 22.

**Steps to create VPC module:**

1. Create VPC resource.
2. Declare use of Availability Zones in the Region configured in the provider (will use 2).
3. Create an Internet Gateway.
4. Create a **private** and a **public** subnet in **each AZ**.
5. Create a **main** route table for the public subnets.
6. Associate the public subnets and the Internet Gateway to the **main** route table.
7. Create a NAT Gateway and EIP in each public subnet (2 total).
8. Create a route table for each private subnet (2 total).
9. Associate each private subnet to a route table created in **step 8**.

**Steps to create EC2 module:**

* Given the following tip: EC2 instance must reside in a public subnet to connect to local machine with SSH.

  1. Use the following Free-tier AMI: Amazon Linux 2 AMI (HVM), SSD Volume Type **ami-0603cbe34fd08cb81**.
  2. Add an **inbound rule** to the instance's security group to **allow SSH via port 22**.
  3. Generate private and public keys with `ssh-keygen` named **task1**.
  4. Create an **aws_key_pair** with the public key.
  5. Give user read permissions with
  ```
  chmod 400 <task1 path>
  ```
  6. Test SSH from local machine to VPC with
  ```
  ssh -i <task1 path> ec2-user@<public IP from AWS console>
  ```
  7. To exit shh mode, type `exit`.
