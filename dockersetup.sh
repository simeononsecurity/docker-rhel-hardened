ansible-galaxy install konstruktoid.hardening
ansible-playbook -i localhost /docker-rhel-hardened/playbook.yml
chmod +x /U_RHEL_8_V1R5_STIG_Ansible/rhel8STIG-ansible/enforce.sh && bash /U_RHEL_8_V1R5_STIG_Ansible/rhel8STIG-ansible/enforce.sh
