# -*- mode: ruby -*-
# vim: set ft=ruby :
# -*- mode: ruby -*-
# vim: set ft=ruby :

MACHINES = {
  :abr1 => {
        :box_name => "centos/7",
        :net => [
                   {ip: '10.0.10.1', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "area1"},
                   {ip: '172.16.12.10', adapter: 3, netmask: "255.255.255.252", virtualbox__intnet: "vlan12"},
                   {ip: '172.16.16.10', adapter: 4, netmask: "255.255.255.252", virtualbox__intnet: "vlan16"},
                ]
  },
  :abr2 => {
        :box_name => "centos/7",
        :net => [
                   {ip: '10.0.20.1', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "area2"},
                   {ip: '172.16.12.9', adapter: 3, netmask: "255.255.255.252", virtualbox__intnet: "vlan12"},
                   {ip: '172.16.20.10', adapter: 4, netmask: "255.255.255.252", virtualbox__intnet: "vlan20"},
                ]
  },
  :abr3 => {
        :box_name => "centos/7",
        :net => [
                   {ip: '10.0.30.1', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "area3"},
                   {ip: '172.16.16.9', adapter: 3, netmask: "255.255.255.252", virtualbox__intnet: "vlan16"},
                   {ip: '172.16.20.9', adapter: 4, netmask: "255.255.255.252", virtualbox__intnet: "vlan20"},
                ]
  },
  :client1 => {
        :box_name => "centos/7",
        :net => [
                   {ip: '10.0.10.2', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "area1"},
                ]
  },
  :client2 => {
        :box_name => "centos/7",
        :net => [
                   {ip: '10.0.20.2', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "area2"},
                ]
  },
}

Vagrant.configure("2") do |config|

  MACHINES.each do |boxname, boxconfig|

    config.vm.define boxname do |box|

        box.vm.box = boxconfig[:box_name]
        box.vm.host_name = boxname.to_s

        boxconfig[:net].each do |ipconf|
          box.vm.network "private_network", ipconf
        end
        
        if boxconfig.key?(:public)
          box.vm.network "public_network", boxconfig[:public]
        end

        box.vm.provision "shell", inline: <<-SHELL
          mkdir -p ~root/.ssh
                cp ~vagrant/.ssh/auth* ~root/.ssh
        SHELL
        end

  end

  config.vm.provision "ansible" do |ansible|
    ansible.verbose = "v"
    ansible.playbook = "provisioning/playbook.yml"
    ansible.sudo = "true"
  end
  
  
end

