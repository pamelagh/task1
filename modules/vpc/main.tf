# VPC
resource "aws_vpc" "main" {
    cidr_block = "${var.vpc_cidr_block}"
}

# Declare data source for AZ's
data "aws_availability_zones" "available" {
    state = "available"
}

# Internet gateway for all networks
resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.main.id}"
}

# Route table to give internet access to networks
resource "aws_route_table" "public-routes" {
    vpc_id = "${aws_vpc.main.id}"
    route {
        cidr_block = "${var.table_routes_cidr_block}"
        gateway_id = "${aws_internet_gateway.default.id}"
    }
}

##################### Public Networks #####################

# First network
resource "aws_subnet" "public-network-1" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.public_network_1_cidr_block}"
    map_public_ip_on_launch = "true"
    availability_zone = "${data.aws_availability_zones.available.names[0]}"
}

# Second network
resource "aws_subnet" "public-network-2" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.public_network_2_cidr_block}"
    map_public_ip_on_launch = "true"
    availability_zone = "${data.aws_availability_zones.available.names[1]}"
}

# Associate first network with route table
resource "aws_route_table_association" "public-1" {
    subnet_id = "${aws_subnet.public-network-1.id}"
    route_table_id = "${aws_route_table.public-routes.id}"
}

# Associate second network with route table
resource "aws_route_table_association" "public-2" {
    subnet_id = "${aws_subnet.public-network-2.id}"
    route_table_id = "${aws_route_table.public-routes.id}"
}
 ##################### Private Networks #####################

 # First network
resource "aws_subnet" "private-network-1" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.private_network_1_cidr_block}"
    map_public_ip_on_launch = "false"
    availability_zone = "${data.aws_availability_zones.available.names[0]}"
}

# Second network
resource "aws_subnet" "private-network-2" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.private_network_2_cidr_block}"
    map_public_ip_on_launch = "false"
    availability_zone = "${data.aws_availability_zones.available.names[1]}"
}

# Elastic IP for 1st AZ
resource "aws_eip" "nat-1" {
    vpc = true
}

# NAT gateway in 1st AZ
resource "aws_nat_gateway" "nat-1" {
    allocation_id = "${aws_eip.nat-1.id}"
    subnet_id     = "${aws_subnet.public-network-1.id}"
    depends_on = [
        "aws_internet_gateway.default"
    ]
}

# Elastic IP for 2nd AZ
resource "aws_eip" "nat-2" {
    vpc = true
}

# NAT gateway in 2nd AZ
resource "aws_nat_gateway" "nat-2" {
    allocation_id = "${aws_eip.nat-2.id}"
    subnet_id     = "${aws_subnet.public-network-2.id}"
    depends_on = [
        "aws_internet_gateway.default"
    ]
}

# Associate NAT gateway in 1st AZ to route table for internet access
resource "aws_route_table_association" "public-nat-1" {
    subnet_id = "${aws_subnet.public-network-1.id}"
    route_table_id = "${aws_route_table.public-routes.id}"
}

# Associate NAT gateway in 2nd AZ to route table for internet access
resource "aws_route_table_association" "public-nat-2" {
    subnet_id = "${aws_subnet.public-network-2.id}"
    route_table_id = "${aws_route_table.public-routes.id}"
}

# Route table for 1st AZ
resource "aws_route_table" "private-routes-1" {
    vpc_id = "${aws_vpc.main.id}"
    route {
        cidr_block = "${var.table_routes_cidr_block}"
        nat_gateway_id = "${aws_nat_gateway.nat-1.id}"
    }
}

# Route table for 2nd AZ
resource "aws_route_table" "private-routes-2" {
    vpc_id = "${aws_vpc.main.id}"
    route {
        cidr_block = "${var.table_routes_cidr_block}"
        nat_gateway_id = "${aws_nat_gateway.nat-2.id}"
    }
}

# Associate first network with route table
resource "aws_route_table_association" "private-1" {
    subnet_id = "${aws_subnet.private-network-1.id}"
    route_table_id = "${aws_route_table.private-routes-1.id}"
}

# Associate second network with route table
resource "aws_route_table_association" "private-2" {
    subnet_id = "${aws_subnet.private-network-2.id}"
    route_table_id = "${aws_route_table.private-routes-2.id}"
}
