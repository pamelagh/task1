resource "aws_ecr_repository" "default" {
  name = "${var.repository_name}"
}

# Builds image and pushes it into aws_ecr_repository
resource "null_resource" "build_and_push_image" {

  # Runs the build.sh script which builds the dockerfile and pushes to ecr
  provisioner "local-exec" {
    command = "bash modules/ecr/build_dockerfile.sh ${var.region} ${var.repository_name} ${aws_ecr_repository.default.repository_url}"
  }
}