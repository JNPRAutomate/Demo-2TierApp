# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

require "vagrant-host-shell"
require "vagrant-junos"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "trusty64-2tier-web", primary: true do |web|
    web.vm.box = "juniper/apache-trusty64"
    web.vm.hostname = "Trusty64-2tier-Web"
    web.vm.network "private_network",
                   ip: "172.16.0.10",
                   virtualbox__intnet: "2Tier-Web"
    web.vm.synced_folder "", "/vagrant"
    web.ssh.password = "vagrant"

    web.vm.provider "virtualbox" do |v|
      # comment out to disable gui from starting
      #v.gui = true
      # comment out below lines if you disable gui
      #v.customize ["modifyvm", :id, "--vram", "128"]
      #v.customize ["modifyvm", :id, "--accelerate3d", "on"]
    end

    #VMware configuration
    web.vm.provider "vmware_fusion" do |v|
      v.vmx["vhv.enable"] = "TRUE"
      v.vmx["ethernet1.generatedAddress"] = nil
      v.vmx["ethernet1.connectionType"] = "custom"
      v.vmx["ethernet1.present"] = "TRUE"
      v.vmx["ethernet1.vnet"] = "vmnet0"
    end

    web.vm.provision "shell" do |s|
      # this script provisions the ndo box for you
      s.path = "scripts/web-setup.sh"
    end

    web.vm.network "forwarded_port", guest: 80, host: 11080

  end

  config.vm.define "trusty64-2tier-db", primary: true do |db|
    db.vm.box = "juniper/mysql-trusty64"
    db.vm.hostname = "Trusty64-2tier-DB"
    db.vm.network "private_network",
                   ip: "172.17.0.10",
                   virtualbox__intnet: "2Tier-Database"
    db.vm.synced_folder "", "/vagrant"
    db.ssh.password = "vagrant"

    db.vm.provider "virtualbox" do |v|
      # comment out to disable gui from starting
      #v.gui = true
      # comment out below lines if you disable gui
      #v.customize ["modifyvm", :id, "--vram", "128"]
      #v.customize ["modifyvm", :id, "--accelerate3d", "on"]
    end

    #VMware configuration
    db.vm.provider "vmware_fusion" do |v|
      v.vmx["vhv.enable"] = "TRUE"
      v.vmx["ethernet1.generatedAddress"] = nil
      v.vmx["ethernet1.connectionType"] = "custom"
      v.vmx["ethernet1.present"] = "TRUE"
      v.vmx["ethernet1.vnet"] = "vmnet1"
    end

    db.vm.provision "shell" do |s|
      # this script provisions the ndo box for you
      s.path = "scripts/db-setup.sh"
    end
  end

  config.vm.define "srx-2tier" do |srx|
    srx.vm.box = "juniper/ffp-12.1X47-D20.7"
    srx.vm.hostname = "2Tier-SRX01"
    srx.vm.network "private_network",
                   ip: "172.16.0.1",
                   nic_type: 'virtio',
                   virtualbox__intnet: "2Tier-Web"
    srx.vm.network "private_network",
                   ip: "172.17.0.1",
                   nic_type: 'virtio',
                   virtualbox__intnet: "2Tier-Database"

    srx.vm.synced_folder "", "/vagrant", disabled: true

    srx.vm.provider "virtualbox" do |v|
      # increase RAM to support AppFW and IPS
      # comment out to make it run at 2GB
      v.customize ["modifyvm", :id, "--memory", "3072"]
      v.check_guest_additions = false
    end

    #VMware configuration
    srx.vm.provider "vmware_fusion" do |v|
      v.vmx["memsize"] = "3072"
      v.vmx["vhv.enable"] = "TRUE"
      v.vmx["ethernet1.generatedAddress"] = nil
      v.vmx["ethernet1.connectionType"] = "custom"
      v.vmx["ethernet1.present"] = "TRUE"
      v.vmx["ethernet1.vnet"] = "vmnet0"
      v.vmx["ethernet2.generatedAddress"] = nil
      v.vmx["ethernet2.connectionType"] = "custom"
      v.vmx["ethernet2.present"] = "TRUE"
      v.vmx["ethernet2.vnet"] = "vmnet1"
    end

    srx.vm.provision "file", source: "scripts/srx-setup.sh", destination: "/tmp/srx-setup.sh"
    srx.vm.provision :host_shell do |host_shell|
      # provides the inital configuration
      host_shell.inline = 'vagrant ssh srx-2tier -c "/usr/sbin/cli -f /tmp/srx-setup.sh"'
    end
  end
end
