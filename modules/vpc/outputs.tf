output "task1_subnet_id" {
  value = "${aws_subnet.public-network-1.id}"
}

output "task1_vpc_id" {
  value = "${aws_vpc.main.id}"
}
