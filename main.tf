# Imagen hello-world
resource "docker_image" "hello" {
  name         = "hello-world:latest"
  keep_locally = false
}

# Contenedor hello-world
resource "docker_container" "hello" {
  name  = "hello-world-container"
  image = docker_image.hello.image_id

  must_run = false # El contenedor se ejecuta una vez y sale.
}
