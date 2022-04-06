ansible-galaxy install konstruktoid.hardening
ansible-playbook -i localhost /docker-rhel-hardened/playbook.yml
ansible-playbook -v -b -i /dev/null /U_RHEL_8_V1R5_STIG_Ansible/rhel8STIG-ansible/site.yml
