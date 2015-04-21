Juniper SRX 2-Tier App Ansible Demo

# Setup initial environment
Connect to the Web Linux host

```
vagrant ssh

cd /vagrant/ansible/
ansible-playbook -i ./inventory.yml playbooks/deploy-database.yml --ask-pass
ansible-playbook -i ./inventory.yml playbooks/deploy-webserver.yml --ask-pass
```

# Deploy Wordpress
We have two sample wordpress customers "Bob" and "Jane", each with their own YAML file. 

```
cd /vagrant/ansible/
ansible-playbook -i ./inventory.yml --extra-vars=@bobpress.yml playbooks/deploy-wordpress.yml --ask-pass

ansible-playbook -i ./inventory.yml --extra-vars=@janepress.yml playbooks/deploy-wordpress.yml --ask-pass
```

# Connect to Wordpress install
We have a Vagrant portforward on port 11080 redirecting to the Webserver (172.16.0.10). You will need to create either a DNS or a host entry for this.
	(http://wp-bob.example.com:11080)

# Remove Wordpress
To remove Wordpress install we call the remove-wordpress.yml playbook with the same Customer YAML file

```
cd /vagrant/ansible/
ansible-playbook -i ./inventory.yml --extra-vars=@bobpress.yml playbooks/remove-wordpress.yml --ask-pass
```

### FIX ANSIBLE LIBRARY PATHING
