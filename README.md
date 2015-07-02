Juniper SRX 2-Tier App Ansible Demo

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

# Simple Deploy

To execute all of the deploy commands without needing to type or copy them out you can use the Ansible makefile. This will still request your credentials at each step. So mind for the prompts as they are asked. It will ask four times.

```
# This will deploy and configure the databases for you. It will not do the remove step
cd /vagrant/ansible/
make all
```

Or also you can deploy each set of steps
```
# This will deploy and configure the databases for you. It will not do the remove step
cd /vagrant/ansible/
make wordpress

#optionally to remove the config
make remove_wordpress
```

Lastly you can test the install
```
cd /vagrant/ansible/
make test_wordpress
```

# Provider Tips

## Virtual box

Generally we have found that virtual box works better with Vagrant. It is recommended, it is free, and since it is used more with Vagrant it ends up working better.

## VMware

When starting instances in VMware there can be some strange behavior. If you run into this please use "vagrant destroy" to delete the VMs and start over with bringing them up.

However once a VMware VM is up and running it is usually more performant than Virtual Box. 
