variable "machine_size" {
  description = "Tamaño de la máquina: s, m, l, xl"
  type        = string
  default     = "s"
}

variable "cpu" {
  description = "Cores asignados"
  type        = number
  default     = 1
}

variable "memory" {
  description = "Memoria asignada en bytes"
  type        = number
  default     = 512000000 # 500 MB
}
