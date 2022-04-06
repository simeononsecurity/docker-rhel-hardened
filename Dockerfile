FROM redhat/ubi8
ENV container docker
ENV TERM=xterm
ENV STIG_PATH=/U_RHEL_8_V1R5_STIG_Ansible/rhel8STIG-ansible/roles/rhel8STIG/files/U_RHEL_8_STIG_V1R5_Manual-xccdf.xml
ENV XML_PATH=/STIGresults.xml

# Update and Install Supporting Packages
RUN dnf -y update && dnf -y upgrade && dnf -y install git wget curl kmod python3 python3-pip python3-virtualenv systemd at net-tools zip unzip
RUN alternatives --set python /usr/bin/python3
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install --upgrade setuptools

# Install Ansible
RUN pip3 install ansible
RUN yum -y --nobest install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
RUN yum -y --nobest --skip-broken install ansible

RUN wget https://dl.dod.cyber.mil/wp-content/uploads/stigs/zip/U_RHEL_8_V1R5_STIG_Ansible.zip
RUN unzip U_RHEL_8_V1R5_STIG_Ansible.zip 
RUN ls -la
RUN cd /U_RHEL_8_V1R5_STIG_Ansible/ && unzip rhel8STIG-ansible.zip

RUN git clone https://github.com/simeononsecurity/docker-ubuntu-hardened.git
RUN cd /docker-ubuntu-hardened/ && chmod +x ./dockersetup.sh
RUN cd /docker-ubuntu-hardened && bash ./dockersetup.sh

ENTRYPOINT [ "/bin/bash" ]
