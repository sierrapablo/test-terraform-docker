# Imagen Ubuntu
resource "docker_image" "ubuntu" {
  name         = "ubuntu:latest"
  keep_locally = true
}

# Contenedor Ubuntu único
resource "docker_container" "ubuntu" {
  name  = "ubuntu-${var.machine_size}-${var.container_suffix}"
  image = docker_image.ubuntu.image_id

  cpu_shares = var.cpu
  memory     = var.memory

  env     = ["DEBIAN_FRONTEND=noninteractive"]
  command = ["tail", "-f", "/dev/null"]

  restart = "unless-stopped"
}
