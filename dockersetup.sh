ansible-galaxy install konstruktoid.hardening
ansible-playbook -i localhost /docker-ubuntu-hardened/playbook.yml
cd /U_RHEL_8_V1R5_STIG_Ansible/rhel8STIG-ansible/ && chmod +x ./enforce.sh && bash ./enforce.sh
