configure
delete security policies from-zone trust to-zone untrust
delete security policies from-zone untrust to-zone trust
delete security policies from-zone trust to-zone trust
set system login user netconf class super-user authentication encrypted-password "$1$b1e7j6ek$4d/RrS9Zw/n6PrmyxKdN7."
set security zones security-zone web interfaces ge-0/0/1.0
set security zones security-zone web host-inbound-traffic system-services all
set security zones security-zone web host-inbound-traffic protocols all
set security zones security-zone database interfaces ge-0/0/2.0
set security zones security-zone database host-inbound-traffic system-services all
set security zones security-zone database host-inbound-traffic protocols all

set security policies from-zone web to-zone database policy MgmtTraffic match source-address any destination-address any application junos-ssh
set security policies from-zone web to-zone database policy MgmtTraffic application junos-ping
set security policies from-zone web to-zone database policy MgmtTraffic then permit

set applications application custom-mysql term mysql-tcp protocol tcp
set applications application custom-mysql term mysql-tcp destination-port 3306
set applications application custom-mysql term mysql-udp protocol udp
set applications application custom-mysql term mysql-udp destination-port 3306
commit and-quit
