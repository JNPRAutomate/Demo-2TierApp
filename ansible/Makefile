all: wordpress


inital:
	ansible-playbook -i ./inventory.yml playbooks/deploy-database.yml --ask-pass
	ansible-playbook -i ./inventory.yml playbooks/deploy-webserver.yml --ask-pass

wordpress:
	ansible-playbook -i ./inventory.yml --extra-vars=@bobpress.yml playbooks/deploy-wordpress.yml --ask-pass
	ansible-playbook -i ./inventory.yml --extra-vars=@janepress.yml playbooks/deploy-wordpress.yml --ask-pass

remove_wordpress:
	ansible-playbook -i ./inventory.yml --extra-vars=@bobpress.yml playbooks/remove-wordpress.yml --ask-pass

test_wordpress:
	curl -v http://localhost -H "Host: wp-bob.example.com"
	curl -v http://localhost -H "Host: wp-jane.example.com"
