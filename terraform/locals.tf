locals {
  presets = {
    s = { cpu = 1024, memory = 512000000 }
    m = { cpu = 2048, memory = 1000000000 }
    l = { cpu = 4096, memory = 2000000000 }
  }

  selected = lookup(local.presets, var.machine_size, local.presets["s"])

  container_suffix = substr(md5(timestamp()), 0, 6)
}
