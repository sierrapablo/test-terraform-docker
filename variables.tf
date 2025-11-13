variable "machine_size" {
  description = "Tamaño de la máquina: s, m, l, xl"
  type        = string
}

variable "cpu" {
  description = "CPU shares para el contenedor"
  type        = number
}

variable "memory" {
  description = "Memoria en bytes para el contenedor"
  type        = number
}

variable "container_suffix" {
  description = "Sufijo único para diferenciar contenedores"
  type        = string
}
