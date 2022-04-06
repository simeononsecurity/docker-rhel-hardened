FROM redhat/ubi8
ENV container docker
ENV TERM=xterm
ENV STIG_PATH=/U_RHEL_8_V1R5_STIG_Ansible/rhel8STIG-ansible/roles/rhel8STIG/files/U_RHEL_8_STIG_V1R5_Manual-xccdf.xml
ENV XML_PATH=/STIGresults.xml

# Update Packages
RUN dnf -y update && dnf -y upgrade

# Install Ansible
RUN yum -y install python3 python3-pip python3-virtualenv
RUN alternatives --set python /usr/bin/python3
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install --upgrade setuptools
RUN python3 -m pip install ansible
RUN yum -y --nobest install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
RUN yum -y --nobest --skip-broken install ansible

RUN git clone https://github.com/simeononsecurity/docker-ubuntu-hardened.git
RUN cd /docker-ubuntu-hardened/ && chmod +x ./dockersetup.sh
RUN cd /docker-ubuntu-hardened && bash ./dockersetup.sh

RUN wget https://dl.dod.cyber.mil/wp-content/uploads/stigs/zip/U_RHEL_8_V1R5_STIG_Ansible.zip
RUN tar -xvf U_RHEL_8_V1R5_STIG_Ansible.zip 
RUN cd /U_RHEL_8_V1R5_STIG_Ansible/ && tar -xvf rhel8STIG-ansible.zip
RUN cd /U_RHEL_8_V1R5_STIG_Ansible/rhel8STIG-ansible/ && chmod +x ./enforce.sh && bash ./enforce.sh
ENTRYPOINT [ "/bin/bash" ]
