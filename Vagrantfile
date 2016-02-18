# -*- mode: ruby -*-
# vi: set ft=ruby :

VM_COUNT=Integer(ENV['VM_COUNT'] || "3")
IMAGE_NAME="ubuntu/trusty64"
IP24NET="10.10.10"
APT_PROXY_URL=ENV["APT_PROXY_URL"]

def shell_script(filename, args=[])
  "/bin/bash #{filename} #{args.join ' '} 2>/dev/null"
end
entries = ""

# Render hosts entries
VM_COUNT.times do |i|
  index = i + 1
  ip_ind = i + 2
  raise if ip_ind > 254
  entries += " \"#{IP24NET}.#{ip_ind} n#{index} n#{index}\""
end

hosts_setup = shell_script("/vagrant/vagrant_script/conf_hosts.sh", [entries])
enable_core_dumps = shell_script("/vagrant/vagrant_script/enable_core_dumps.sh")
install_software = shell_script("/vagrant/vagrant_script/install_software.sh", [APT_PROXY_URL])
join_rabbit = shell_script("/vagrant/vagrant_script/join_rabbit.sh")
set_rabbit_policies = shell_script("/vagrant/vagrant_script/set_rabbit_policies.sh")

Vagrant.configure(2) do |config|
  VM_COUNT.times do |i|
    index = i + 1
    ip_ind = i + 2
    raise if ip_ind > 254
    config.vm.define "n#{index}" do |config|
      config.vm.box = IMAGE_NAME
      
      config.vm.provider :virtualbox do |domain|
        domain.memory = 2048
        domain.cpus = 2
      end
      config.vm.host_name = "n#{index}"
      config.vm.network :private_network, ip: "#{IP24NET}.#{ip_ind}", :mode => 'nat'
      config.vm.provision "shell", run: "always", inline: hosts_setup, privileged: true
      config.vm.provision "shell", inline: enable_core_dumps, privileged: true
      config.vm.provision "shell", inline: install_software, privileged: true

      if i == 0 then
        config.vm.provision "shell", inline: set_rabbit_policies, privileged: true
      else
        config.vm.provision "shell", inline: join_rabbit, privileged: true
      end
    end
  end
end
