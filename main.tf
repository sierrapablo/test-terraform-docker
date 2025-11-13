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

  command = [
    "bash", "-c", <<EOT
    apt-get update && apt-get install -y passwd sudo &&
    useradd -m -s /bin/bash ubuntu &&
    echo 'ubuntu:ubuntu' | chpasswd &&
    usermod -aG sudo ubuntu &&
    echo 'root:root' | chpasswd &&
    tail -f /dev/null
    EOT
  ]

  restart = "unless-stopped"
}
