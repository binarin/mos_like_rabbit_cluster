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
install_software = shell_script("/vagrant/vagrant_script/install_software.sh", [APT_PROXY_URL])

Vagrant.configure(2) do |config|
  VM_COUNT.times do |i|
    index = i + 1
    ip_ind = i + 2
    raise if ip_ind > 254
    config.vm.define "n#{index}" do |config|
      config.vm.box = IMAGE_NAME
      config.vm.provider :libvirt do |domain|
        domain.memory = 2048
      end
      config.vm.host_name = "n#{index}"
      config.vm.network :private_network, ip: "#{IP24NET}.#{ip_ind}", :mode => 'nat'
      config.vm.provision "shell", run: "always", inline: hosts_setup, privileged: true
      config.vm.provision "shell", inline: install_software, privileged: true
    end
  end
end
