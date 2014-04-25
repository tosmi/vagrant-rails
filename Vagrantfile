# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define "dev" do |dev|
    dev.vm.box = "centos-65-x64-virtualbox-puppet"
    dev.vm.hostname = 'railsdev'
    dev.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-puppet.box"

    dev.vm.provision :puppet do |puppet|
      puppet.manifest_file  = "init.pp"
      puppet.manifests_path = "vagrant/puppet/manifests"
      puppet.module_path = "vagrant/puppet/modules"
    end
  end
end
