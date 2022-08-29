ansible-galaxy install konstruktoid.hardening
ansible-playbook -i localhost /docker-rhel-hardened/playbook.yml
ansible-playbook -e ignore_errors=yes -v -b -i /dev/null /U_RHEL_8_V1R7_STIG_Ansible/rhel8STIG-ansible/site.yml
