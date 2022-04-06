FROM redhat/ubi8-minimal
ENV container docker
ENV TERM=xterm

# Update Packages
RUN yum -y upgrade 

# Install Ansible
RUN yum -y install epel-release
RUN yum -y install ansible 

RUN git clone https://github.com/simeononsecurity/docker-ubuntu-hardened.git
RUN cd /docker-ubuntu-hardened/ && chmod +x ./dockersetup.sh
RUN cd /docker-ubuntu-hardened && bash ./dockersetup.sh

ENTRYPOINT [ "/bin/bash" ]
