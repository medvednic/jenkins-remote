# Jenkins on remote machine using SSH and Terraform

This repository contains scripts for creating a Jenkins server on a remote machine using Terraform and bash commands via SSH.
## Requirements 

* OS capable of executing bash

* [Terraform](https://www.terraform.io/) (tested with v0.11.11)

* Remote Debian Strech machine which has your public ssh key

* External IP address of the remote machine


## Usage
Let 35.236.114.144 be the machine IP address, pass the address as an argument to the script.

```bash
./solution.sh 35.236.114.144 
```
If all the mentioned requirements are met, after the script finished execution (couple of minutes) you should be able to access Jenkins UI by entering the IP address in you favorite browser.

In order to unlock Jenkins we need the initial admin password, you can get it by executing the following command from your local machine:

```bash
ssh 35.236.114.144 docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword 
```


### Brief explanation
The following bash commands are executed via SSH connection to the remote machine:

1. Docker CE is installed on the remote machine using apt-get.
2. Docker is configured to start on OS boot.
3. Docker service is configured to accept requests from remote hosts by  altering the docker.service file.

Terraform is executed from the local machine to spin up docker container which would run Jenkins on the remote machine (host property of docker terraform provider).

Port 8080 of the Jenkins container is mapped to 80 for convenient access via a web browser.

### Things which can be improved
* Host input validation
* Bash commands exit status checks
* Finer configuration of Jenkins using custom Dockerfile
* Automatically get the initial admin password once Jenkins server is up

## References
[Installing docker on Debian](https://docs.docker.com/install/linux/docker-ce/debian/)

[Docker post-installation steps for linux](https://docs.docker.com/install/linux/linux-postinstall/)

[How to Enable Docker Remote REST API on Docker Host](http://www.littlebigextra.com/how-to-enable-remote-rest-api-on-docker-host/)

[Docker Provider for Terraform](http://www.littlebigextra.com/how-to-enable-remote-rest-api-on-docker-host/)

[Jenkins Docker Image](https://github.com/jenkinsci/docker/blob/master/README.md)