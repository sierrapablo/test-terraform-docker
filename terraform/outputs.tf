output "container_name" {
  description = "The name of the Ubuntu container"
  value       = docker_container.ubuntu.name
}

output "container_id" {
  description = "The Docker container ID"
  value       = docker_container.ubuntu.id
}

output "container_ip" {
  description = "The IP address of the container (if needed)"
  value       = docker_container.ubuntu.network_data[0].ip_address
}
