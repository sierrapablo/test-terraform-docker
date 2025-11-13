resource "docker_image" "ubuntu" {
  name = "ubuntu:latest"
}

resource "docker_container" "ubuntu" {
  for_each = {
    "${var.machine_size}-${local.container_suffix}" = local.selected
  }

  name       = "ubuntu-${each.key}"
  image      = docker_image.ubuntu.image_id
  cpu_shares = each.value.cpu
  memory     = each.value.memory

  command = ["tail", "-f", "/dev/null"]
  restart = "unless-stopped"
}
