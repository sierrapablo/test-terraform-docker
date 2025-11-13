variable "machine_size" {
  description = "Machine size label (s, m, l, etc.)"
  type        = string
}

variable "cpu" {
  description = "CPU shares"
  type        = number
  default     = 1024
}

variable "memory" {
  description = "Memory limit in bytes"
  type        = number
  default     = 512000000
}

variable "container_suffix" {
  description = "Unique suffix for container name"
  type        = string
}
