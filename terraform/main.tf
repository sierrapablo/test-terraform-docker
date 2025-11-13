resource "docker_image" "ubuntu" {
  name = "ubuntu:latest"
}

resource "docker_container" "ubuntu" {
  name  = "ubuntu-${var.machine_size}-${local.container_suffix}"
  image = docker_image.ubuntu.image_id

  cpu_shares = local.selected.cpu
  memory     = local.selected.memory

  command = ["tail", "-f", "/dev/null"]
  restart = "unless-stopped"
}
