FROM redhat/ubi8
ENV container docker
ENV TERM=xterm

# Update Packages
RUN dnf -y update && dnf -y upgrade

# Install Ansible

RUN yum -y install python3 python3-pip python3-virtualenv
RUN alternatives --set python /usr/bin/python3
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install --upgrade setuptools
RUN python3 -m pip install ansible
RUN yum -y --nobest install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
RUN yum -y install ansible

RUN git clone https://github.com/simeononsecurity/docker-ubuntu-hardened.git
RUN cd /docker-ubuntu-hardened/ && chmod +x ./dockersetup.sh
RUN cd /docker-ubuntu-hardened && bash ./dockersetup.sh

ENTRYPOINT [ "/bin/bash" ]
