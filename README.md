# Jenkins on remote machine using SSH and Terraform

This repository contains scripts for creating a Jenkins server on a remote machine using Terraform and bash commands via SSH.
## Requirements 

* OS capable of executing bash (tested on macOS 10.14.5)

* [Terraform](https://www.terraform.io/) (tested with v0.11.11)

* Remote Debian Strech machine which has your public ssh key, and at least one tcp port exposed

* External IP address of the remote machine


## Usage
Let 34.73.82.218 be the machine IP address and 8080 the exposed port. 

Pass the IP address as an argument to the script.

_Note that if your exposed port differs from 8080, pass it as the second argument._

```bash
./solution.sh 34.73.82.218
```

If all the mentioned requirements are met, after the script finished execution (few minutes) you should be able to access [Jenkins UI](https://ibb.co/6vc0zfQ) by entering [34.73.82.218:8080](http://34.73.82.218:8080) in you favorite browser.

In order to unlock Jenkins we need the initial admin password, you can get it by executing the following command from your local machine:

```bash
ssh 34.73.82.218 docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword 
```

### Brief explanation
The solution.sh script executes sets of bash commands via SSH connection to the remote machine, in general:

1. Docker-CE is installed on the remote machine using apt-get.
2. Docker is configured to start on OS boot.

Terraform is executed from the local machine to spin up the docker container which would run Jenkins on the remote machine (docker provider also uses ssh host).

### Things which can be improved
* Host input validation
* Bash commands exit status checks
* Finer configuration of Jenkins using custom Dockerfile
* Automatically get the initial admin password once Jenkins server is up

## References
[Installing docker on Debian](https://docs.docker.com/install/linux/docker-ce/debian/)

[Docker post-installation steps for linux](https://docs.docker.com/install/linux/linux-postinstall/)

[Docker Provider for Terraform](https://www.terraform.io/docs/providers/docker/)

[Jenkins Docker Image](https://github.com/jenkinsci/docker/blob/master/README.md)
