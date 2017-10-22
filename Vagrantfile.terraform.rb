# -*- mode: ruby -*-
ENV['VM_IP'].nil? ? VM_IP = '192.168.56.123'.freeze : VM_IP = ENV['VM_IP']
SSH_OPTS = '-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'.freeze
virtual_machines = {}
virtual_machines['terraform-adm'] = VM_IP
ssh_key_file = "#{Dir.home}/.ssh/id_rsa.pub"
ssh_public_key = File.read(ssh_key_file).strip if File.exist?(ssh_key_file)
prepare_ssh = %(
  mkdir -p /home/vagrant/.ssh
  echo '#{ssh_public_key}' >> /home/vagrant/.ssh/authorized_keys

  mkdir -p /root/.ssh
  echo '#{ssh_public_key}' >> /root/.ssh/authorized_keys
)
run_tests = 'cd /vagrant/serverspec && /usr/local/bin/rake spec'
run_terraform = "ssh #{SSH_OPTS} root@#{VM_IP} 'make -C /vagrant terraform'"

Vagrant.configure('2') do |config|
  config.vm.synced_folder '.', '/vagrant'

  virtual_machines.each do |name, ip|
    config.vm.define name do |host|
      host.vm.box = 'bento/centos-7.2'
      host.vm.network 'private_network', ip: ip
      host.vm.hostname = name

      host.vm.provider 'virtualbox' do |box|
        box.memory = 3072
        box.cpus = 2
        box.customize ['modifyvm', :id,
                       '--nic1', 'nat',
                       '--cableconnected1', 'on',
                       '--nicpromisc1', 'allow-all']
      end
    end
    config.vm.provision :shell, inline: prepare_ssh if File.exist?(ssh_key_file)
    config.vm.provision :ansible_local do |ansible|
      ansible.playbook = 'provision/adm.yml'
      ansible.install = true
    end
    config.vm.provision :shell, inline: run_tests
    config.vm.provision :shell, inline: run_terraform
  end
end
