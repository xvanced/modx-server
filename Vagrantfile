# -*- mode: ruby -*-
# vi: set ft=ruby :

# Project specific variables
projectName='Project'
projectUrl='project.test'
projectAliases=%w(www.project.test)
modxVersion='2.7.1'
machineName='modx'
projectPackage='xVanced-MODX'

# VM variables
vmBox='bento/ubuntu-16.04'
vmCpus=2
vmRam=1024

# Vagrant variables
vagrantfile_min_version = '1.7.0'
vagrantfile_api_version = '2'
vagrantfile_plugins = %w(vagrant-vbguest vagrant-hostmanager vagrant-env)
vagrantfile_plugin_vbguest ='on'

# Check minimum required Vagrant
Vagrant.require_version ">= #{vagrantfile_min_version}"

# Check and install required plugins
if Gem::Version.new(Vagrant::VERSION) < Gem::Version.new("2.1.3")
  vagrantfile_plugins.each do |plugin|
    unless Vagrant.has_plugin?("#{plugin}")
      if ! system "vagrant plugin install #{plugin}"
        abort "Error: missing plugin. Failed to run 'vagrant plugin install #{plugin}'"
      end
    end
  end
end

Vagrant.configure(vagrantfile_api_version) do |config|

  # Setup required plugins for newer versions
  if Gem::Version.new(Vagrant::VERSION) >= Gem::Version.new("2.1.3")
    config.vagrant.plugins = vagrantfile_plugins
  end

  config.env.enable
  config.vm.box = ENV.has_key?('VM_BOX') ? ENV['VM_BOX'] : vmBox
  config.ssh.insert_key = true

  # Machine name for vagrant
  config.vm.define machineName do |node|

    # Hostname in ssh'ed guest-machine (before dot)
    # and hosts-file entry on the host-machine
    node.vm.hostname = ENV.has_key?('PROJECT_URL') ? ENV['PROJECT_URL'] : projectUrl

    # Additional hosts-entries
    node.hostmanager.aliases = ENV.has_key?('PROJECT_ALIASES') ? ENV['PROJECT_ALIASES'] : projectAliases

    # Synced directories
    node.vm.synced_folder '../_backup', '/var/www/_backup/'
    node.vm.synced_folder '../_data', '/var/www/_data/'
    node.vm.synced_folder '../_keys', '/var/www/_keys/'
    node.vm.synced_folder '../www', '/var/www/html/'
    node.vm.synced_folder '.', '/var/www/_server/'

    # Ansible provisioner
    node.vm.provision 'ansible' do |ansible|
      ansible.compatibility_mode = '2.0'
      ansible.playbook = 'ansible/playbook.yml'
      ansible.extra_vars = {
          ansible_ssh_user: 'vagrant',
          modx_host: ENV.has_key?('PROJECT_URL') ? ENV['PROJECT_URL'] : projectUrl,
          modx_version: ENV.has_key?('MODX_VERSION') ? ENV['MODX_VERSION'] : modxVersion
      }
    end

    # Network settings
    node.vm.network :private_network,
                    :type => 'dhcp',
                    :adapter => 2
  end

  # VirtualBox Guest Plugin
  if vagrantfile_plugin_vbguest == 'on'
    config.vbguest.auto_update = true
    #config.vbguest.iso_path = 'vbox/VBoxGuestAdditions_6.0.9-130569.iso'
    config.vbguest.no_remote = false
  else
    config.vbguest.auto_update = false
    config.vbguest.no_remote = true
  end

  # Add entries to the /etc/hosts file on the host system.
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = false
  config.hostmanager.ip_resolver = proc do |machine|
    result = ''
    machine.communicate.execute("hostname -I | awk '{print $2}'") do |type, data|
      result << data if type == :stdout
    end
    (ip = /(\d+\.\d+\.\d+\.\d+)/.match(result)) && ip[1]
  end

  # Setup VirtualBox-box
  config.vm.provider :virtualbox do |box|
    # VM-Name in VirtualBox
    box.name = (ENV.has_key?('PROJECT_PACKAGE') ? ENV['PROJECT_PACKAGE'] : projectPackage) + '-' +
        (ENV.has_key?('PROJECT_NAME') ? ENV['PROJECT_NAME'] : projectName)
    box.memory = ENV.has_key?('VM_RAM') ? ENV['VM_RAM'] : vmRam
    box.cpus = ENV.has_key?('VM_CPUS') ? ENV['VM_CPUS'] : vmCpus
    box.customize ['modifyvm', :id, '--cpuexecutioncap', '90']
    box.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    box.customize ['modifyvm', :id, '--ioapic', 'on']
  end

end
