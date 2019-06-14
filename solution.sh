#!/usr/bin/env bash

HOST=$1

init_tfvars () {
    sed -i '.bak' s#^docker_host.*#docker_host=\"tcp://${HOST}:2375\"# terraform.tfvars
}

install_docker_on_remote () {
    ssh ${HOST} << EOF
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
EOF
}

configure_remote_docker_api () {
    ssh ${HOST} << EOF
    sudo sed -i "s#^ExecStart=.*#ExecStart=/usr/bin/dockerd -H fd:// -H=tcp://0.0.0.0:2375#" \
    /lib/systemd/system/docker.service

    sudo systemctl daemon-reload
    sudo systemctl restart docker.service
EOF
}

spin_up_jenkins_container_on_remote () {
    terraform init
    terraform plan
    terraform apply
}

init_tfvars
install_docker_on_remote
configure_remote_docker_api
sleep 5
spin_up_jenkins_container_on_remote