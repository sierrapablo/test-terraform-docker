# Imagen Ubuntu
resource "docker_image" "ubuntu" {
  name         = "ubuntu:latest"
  keep_locally = true
}

# Contenedor ubuntu con nombre único
resource "docker_container" "ubuntu" {
  name  = "ubuntu-${timestamp()}"
  image = docker_image.ubuntu.image_id

  env     = ["DEBIAN_FRONTEND=noninteractive"]
  command = ["tail", "-f", "/dev/null"]
  restart = "unless-stopped"

  cpu_shares = var.cpu * 1024 # Docker usa unidades relativas
  memory     = var.memory
}
