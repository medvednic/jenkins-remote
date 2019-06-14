variable "docker_host" {
  description = "Remote docker daemon"
  default = "tcp://localhost:2375"
}

variable "container_name" {
  description = "Container name"
  default = "jenkins"
}

variable "jenkins_external" {
  description = "Jenkins external port"
  default = 8080
}
