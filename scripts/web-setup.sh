#!/usr/bin/env bash
export ANSIBLE_LIBRARY=/etc/ansible/roles:/usr/share/pyshared
if ! grep -qe "export ANSIBLE_LIBRARY=/etc/ansible/roles:/usr/share/pyshared" "/home/vagrant/.bashrc"; then
    cat >> /home/vagrant/.bashrc <<EOF

export ANSIBLE_LIBRARY=/etc/ansible/roles:/usr/share/pyshared
export ANSIBLE_HOST_KEY_CHECKING=False
EOF
fi

sudo ip r a 172.17.0.0/24 via 172.16.0.1 dev eth1

cat >> /etc/network/interfaces <<EOF

post-up route add -net 172.17.0.0 netmask 255.255.255.0 gw 172.16.0.1 dev eth1
EOF

sudo apt-get purge network-manager -y
sudo ifdown eth1
sudo ifup eth1
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update -y
sudo apt-get install -y python-pip python-dev libxml2-dev libxslt-dev python-lxml -y
sudo apt-get install ansible -y
sudo pip install junos-eznc
sudo pip install junos-netconify
sudo ansible-galaxy install Juniper.junos
sudo rm -rf /etc/ansible/ansible.cfg
