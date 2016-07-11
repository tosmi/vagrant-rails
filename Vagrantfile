# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.ssh.forward_agent = true

  config.vm.define "railsdev" do |dev|
    dev.vm.box = "puppetlabs/centos-7.2-64-puppet"
    dev.vm.hostname = 'railsdev'
    dev.vm.network "forwarded_port", guest: 80,   host: 8086
    dev.vm.network "forwarded_port", guest: 443,  host: 8443
    dev.vm.network "forwarded_port", guest: 3000, host: 3000

    dev.vm.provision :puppet do |puppet|
      puppet.environment_path = "puppet/environments"
      puppet.environment = "vagrant"
    end
  end
end
