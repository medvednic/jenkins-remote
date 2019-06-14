provider "docker" {
  host = "${var.docker_host}"
}

resource "docker_container" "jenkins" {
  image = "${docker_image.jenkins.latest}"
  name  = "${var.container_name}"

  ports {
    internal = 8080
    external = "${var.jenkins_external}"
  }

  ports {
    internal = 50000
    external = 50000
  }

  labels {
    app = "curv"
  }
}

resource "docker_image" "jenkins" {
  name = "jenkins/jenkins:lts"
}

output "remote-docker-host" {
  value = "${var.docker_host}"
}