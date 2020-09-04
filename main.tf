terraform {
  required_version = ">= 0.11"
}

provider "aws" {
    profile = "${var.profile}"
    region  = "${var.region}"
}

module "vpc" {
    source = "./modules/vpc"

    vpc_cidr_block = "${var.vpc_cidr_block}"

    table_routes_cidr_block = "${var.table_routes_cidr_block}"

    private_network_1_cidr_block = "${var.private_network_1_cidr_block}"
    private_network_2_cidr_block = "${var.private_network_2_cidr_block}"

    public_network_1_cidr_block = "${var.public_network_1_cidr_block}"
    public_network_2_cidr_block = "${var.public_network_2_cidr_block}"
}

module "ec2" {
    source = "./modules/ec2"

    vpc_id = "${module.vpc.task1_vpc_id}"
    subnet_id = "${module.vpc.task1_subnet_id}"
}
