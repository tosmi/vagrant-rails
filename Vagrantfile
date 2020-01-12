# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.ssh.forward_agent = true
  config.vm.box_check_update = false
  config.vm.synced_folder "./", "/vagrant", type: "sshfs"

  config.vm.define "railsdev" do |dev|
    dev.vm.box = "centos/7"
    dev.vm.hostname = 'railsdev'
    dev.vm.network "forwarded_port", guest: 80,   host: 8086
    dev.vm.network "forwarded_port", guest: 443,  host: 8443
    dev.vm.network "forwarded_port", guest: 3000, host: 3000

    dev.vm.provision 'shell', inline: 'yum -q -y install ansible centos-release-scl'

    dev.vm.provision :ansible_local do |a|
      a.playbook = 'provision.yml'
      a.compatibility_mode = '2.0'
    end
  end
end
