# Definimos un prefijo para todos los recursos que se crearán
variable "prefix" {
  default = "iva-unir-k8s"
}


# Definimos la zona donde se crearan los recursos
variable "location" {
  type = string
  description = "Región de Azure donde crearemos la infraestructura"
  default = "West Europe"
}

# Usuario por defecto (ansible puesto que será quien realizará todas las tareas de adminsitración)
variable "defadmonuser" {
  type = string
  description = "Usuario de administración por defecto"
  default = "ansible"
}

# Definimos los size para cada tipo de máquina
variable "vm_size_master" {
  type = string
  description = "Tamaño de la máquina virtual MASTER"
  default = "Standard_A2_v2" # 4GB, 2 CPU 
}

variable "vm_size_worker" {
  type = string
  description = "Tamaño de las máquinas virtuales de los WORKERS"
  default = "Standard_A1_v2" # 2GB, 1 CPU 
}
