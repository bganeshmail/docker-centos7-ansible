# CentOS 7.x Ansible Test Image

[![Docker Automated build](https://img.shields.io/docker/automated/geerlingguy/docker-centos7-ansible.svg?maxAge=2592000)](https://hub.docker.com/r/geerlingguy/docker-centos7-ansible/)

CentOS 7.x Docker container for Ansible, Terraform, and HPE OneView testing.

## How to Build

  1. [Install Docker](https://docs.docker.com/engine/installation/).
  2. `cd` into this directory.
  3. Run `docker build -t centos7-ansible-oneview .`

## How to Use

  1. [Install Docker](https://docs.docker.com/engine/installation/).
  2. Use the image that you just built by running `docker run -it centos7-ansible-oneview /bin/bash`
  
## Notes

I am using this image to test running Ansible and Terraform against HPE Synergy hardware and OneView.  I've also include the installation of the HPE OneView SDK and OneView Ansible modules. 

> **Important Note**: I use this image for testing in an isolated environment—not for production—and the settings and configuration used may not be suitable for a secure and performant production environment. Use on production servers/in the wild at your own risk!

## Author

Created in 2016 by [Jeff Geerling](http://jeffgeerling.com/), author of [Ansible for DevOps](https://www.ansiblefordevops.com/).

Forked and updated 2018 by [Ned Bellavance](https://nedinthecloud.com)
