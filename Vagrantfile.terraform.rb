# -*- mode: ruby -*-
virtual_machines = {}
virtual_machines['terraform-adm'] = '192.168.56.123'
ssh_public_key = File.read("#{Dir.home}/.ssh/id_rsa.pub").strip
prepare_ssh = %(
  mkdir -p /home/vagrant/.ssh
  echo '#{ssh_public_key}' >> /home/vagrant/.ssh/authorized_keys

    mkdir -p /root/.ssh
    echo '#{ssh_public_key}' >> /root/.ssh/authorized_keys
)

Vagrant.configure('2') do |config|
  config.vm.synced_folder '.', '/vagrant'

  virtual_machines.each do |name, ip|
    config.vm.define name do |host|
      host.vm.box = 'bento/centos-7.2'
      host.vm.network 'private_network', ip: ip
      host.vm.hostname = name

      host.vm.provider 'virtualbox' do |box|
        box.memory   = 2048
        box.cpus     = 2
        box.customize ['modifyvm', :id,
                       '--nic1', 'nat',
                       '--cableconnected1', 'on',
                       '--nicpromisc1', 'allow-all']
      end
    end
    config.vm.provision 'shell', inline: prepare_ssh
    config.vm.provision 'ansible' do |ansible|
      ansible.playbook = 'provision/adm.yml'
    end
  end
end
