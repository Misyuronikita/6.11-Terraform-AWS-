variable "user_names" {
  type    = list(string)
  default = ["Givi", "Selin", "Slavik", "Rita"]
}

variable "user_groups" {
  type    = list(string)
  default = ["Developers-Group-Innowise", "DevOps-Group-Innowise"]
}

variable "developers_group" {
  type    = list(string)
  default = ["Givi", "Selin"]
}

variable "devopses_group" {
  type    = list(string)
  default = ["Slavik", "Rita"]
}
