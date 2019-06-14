#!/usr/bin/env bash

REMOTE_HOST=$1

init_tfvars () {
    touch terraform.tfvars
    echo docker_host=\"ssh://${REMOTE_HOST}\" > terraform.tfvars
}

install_docker_on_remote () {
    ssh ${REMOTE_HOST} << EOF
    sudo apt-get -y update

    sudo apt-get -y install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        software-properties-common

    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

    sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \$(lsb_release -cs) stable"

    sudo apt-get -y update

    sudo apt-get -y install \
        docker-ce \
        docker-ce-cli \
        containerd.io

    sudo groupadd docker
    sudo usermod -aG docker $USER

    sudo systemctl enable docker
EOF
}

spin_up_jenkins_container_on_remote () {
    terraform init
    terraform plan
    terraform apply -auto-approve
}

init_tfvars
install_docker_on_remote
spin_up_jenkins_container_on_remote
