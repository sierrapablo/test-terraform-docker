# Generar un ID aleatorio para el contenedor
resource "random_id" "suffix" {
  byte_length = 3
}

# Imagen Ubuntu
resource "docker_image" "ubuntu" {
  name         = "ubuntu:latest"
  keep_locally = true
}

# Contenedor ubuntu con nombre único
resource "docker_container" "ubuntu" {
  name  = "ubuntu-${random_id.suffix.hex}"
  image = docker_image.ubuntu.image_id

  env = ["DEBIAN_FRONTEND=noninteractive"]

  command = ["tail", "-f", "/dev/null"]

  restart = "unless-stopped"
}
