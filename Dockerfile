#Forked from Jeff Geerling
FROM centos:7
LABEL maintainer="Ned Bellavance"
ENV container=docker

# Install systemd -- See https://hub.docker.com/_/centos/
RUN yum -y update; yum clean all; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

# Install Ansible and other requirements.
RUN yum makecache fast \
 && yum -y install deltarpm epel-release initscripts \
 && yum -y update \
 && yum -y install \
      python34 \
      python34-pip \
      ansible \
      sudo \
      which \
      unzip \
      git \
 && yum clean all

#Install Terraform 0.11.7
RUN curl -O https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip \
 && unzip terraform_0.11.7_linux_amd64.zip -d /usr/bin/

#Install OneView SDK
RUN git clone https://github.com/HewlettPackard/python-hpOneView.git \
 && cd python-hpOneView \
 && python setup.py install \
 && cd ..

#Install the Ansible OneView module
RUN git clone https://github.com/HewlettPackard/oneview-ansible.git

ENV ANSIBLE_LIBRARY=/oneview-ansible/library ANSIBLE_MODULE_UTILS=/oneview-ansible/library/module_utils/

# Disable requiretty.
RUN sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/'  /etc/sudoers

# Install Ansible inventory file.
RUN echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/sbin/init"]
