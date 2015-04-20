#!/usr/bin/env bash
export ANSIBLE_LIBRARY=/etc/ansible/roles/
if ! grep -qe "export ANSIBLE_LIBRARY=/etc/ansible/roles/" "/home/vagrant/.bashrc"; then
    cat >> /home/vagrant/.bashrc <<EOF

export ANSIBLE_LIBRARY=/etc/ansible/roles/
export ANSIBLE_HOST_KEY_CHECKING=False
EOF
fi



sudo ip r a 172.16.0.0/24 via 172.17.0.1 dev eth1

cat >> /etc/network/interfaces <<EOF

post-up route add -net 172.16.0.0 netmask 255.255.255.0 gw 172.17.0.1 dev eth1
EOF

sudo apt-get purge network-manager -y
sudo ifdown eth1
sudo ifup eth1
