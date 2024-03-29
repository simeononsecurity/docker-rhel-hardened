FROM redhat/ubi8

LABEL org.opencontainers.image.source="https://github.com/simeononsecurity/docker-rhel-hardened"
LABEL org.opencontainers.image.description="Prehardenend RHEL Docker Container with arm64 and amd64 support"
LABEL org.opencontainers.image.authors="simeononsecurity"

ENV container docker
ENV TERM=xterm
ENV STIG_PATH=/U_RHEL_8_V1R9_STIG_Ansible/rhel8STIG-ansible/roles/rhel8STIG/files/_Red_Hat_Enterprise_Linux_8_STIG_V1R9_Manual-xccdf.xml
ENV XML_PATH=/STIGresults.xml

# Update and Install Supporting Packages
RUN dnf -y update && dnf -y --setopt=install_weak_deps=False upgrade && dnf -y --setopt=install_weak_deps=False install git wget curl kmod python3 python3-pip python3-virtualenv systemd at net-tools zip unzip
RUN alternatives --set python /usr/bin/python3
RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install --no-cache-dir --upgrade setuptools

# Install Ansible
RUN pip3 install ansible --no-cache-dir
RUN yum -y --nobest install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
RUN yum -y --nobest --skip-broken install ansible

#Setup DoD Ansible Playbook for RHEL8
COPY ./files/U_RHEL_8_V1R9_STIG_Ansible.zip ./U_RHEL_8_V1R9_STIG_Ansible.zip
RUN unzip U_RHEL_8_V1R9_STIG_Ansible.zip -d '/U_RHEL_8_V1R9_STIG_Ansible/'
RUN cd /U_RHEL_8_V1R9_STIG_Ansible/ && unzip -d '/U_RHEL_8_V1R9_STIG_Ansible/rhel8STIG-ansible/' rhel8STIG-ansible.zip

#Run konstruktoid.hardening and DoD Rhel 8 Playbook
RUN git clone https://github.com/simeononsecurity/docker-rhel-hardened.git
RUN ls -la
RUN cd /docker-rhel-hardened/ && chmod +x ./dockersetup.sh
RUN cd /docker-rhel-hardened/ && bash ./dockersetup.sh ; exit 0

# Clean RPM Cache
RUN dnf clean all

ENTRYPOINT [ "/bin/bash" ]
