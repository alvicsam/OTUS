# -*- mode: ruby -*-
# vim: set ft=ruby :
# -*- mode: ruby -*-
# vim: set ft=ruby :

MACHINES = {
  :inetRouter => {
        :box_name => "centos/7",
        :net => [
                   {adapter: 2, virtualbox__intnet: "router-server"},
                   {adapter: 3, virtualbox__intnet: "router-server"},
                ]
  },
  :centralServer => {
        :box_name => "centos/7",
        :net => [
                   {adapter: 2, virtualbox__intnet: "router-server"},
                   {adapter: 3, virtualbox__intnet: "router-server"},
                ]
  },
  :testClient1 => {
        :box_name => "centos/7",
        :net => [
                   {adapter: 2, virtualbox__intnet: "router-server"},
                ]
  },
  :testServer1 => {
        :box_name => "centos/7",
        :net => [
                   {adapter: 2, virtualbox__intnet: "router-server"},
                ]
  },
  :testClient2 => {
        :box_name => "centos/7",
        :net => [
                   {adapter: 2, virtualbox__intnet: "router-server"},
                ]
  },
  :testServer2 => {
        :box_name => "centos/7",
        :net => [
                   {adapter: 2, virtualbox__intnet: "router-server"},
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

