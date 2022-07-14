# -*- mode: ruby -*-
# vi: set ft=ruby :

node = { :type => "dhcp", :memory => 1024, :cpu => 1, :boxname => "ubuntu/focal64" }
   
Vagrant.configure("2") do |config|
    
    config.vm.provision :ansible do |ansible|
        ansible.playbook = "provision/playbook.yml"
        ansible.groups = {   
           "WEB" => ["web"],
           "DB" => ["db"],
           "ROUTER" => ["router"]
        }
    end
        
    config.vm.define "router" do |router|
        router.vm.provision :ansible do |ansible|
            ansible.playbook = "provision/router_config.yaml"
            
        end
        router.vm.box = node[:boxname]
        router.vm.hostname = "router"
        router.vm.network "private_network", type: node[:type], name: "vboxnet0", adapter: 2
        router.vm.network "private_network", ip: "192.168.11.57", adapter: 3
        router.vm.provider :virtualbox do |vb|
              vb.memory = node[:memory]
              vb.cpus = node[:cpu]
              
        end
    end
    
    config.vm.define "db" do |db|
        db.vm.provision :ansible do |ansible|
            ansible.playbook = "provision/db_config.yaml"
            ansible.vault_password_file = "provision/vault_pass"
        
        end
        db.vm.box = node[:boxname]
        db.vm.hostname = "db"
        db.vm.network "private_network", type: node[:type], name: "vboxnet0", adapter: 2
        
        (0..3).each do |i|
            db.vm.disk :disk, size: "1GB", name: "disk-#{i}"
        end
        db.vm.provider :virtualbox do |vb|
              vb.memory = node[:memory]
              vb.cpus = node[:cpu]
        end
    end    
    
    config.vm.define "web" do |web|
        web.vm.provision :ansible do |ansible|
            ansible.playbook = "provision/web_config.yaml"
            ansible.vault_password_file = "provision/vault_pass"
       
        end        
        web.vm.box = node[:boxname]
        web.vm.hostname = "web"
        web.vm.network "private_network", type: node[:type], name: "vboxnet1", adapter: 2
        web.vm.provider :virtualbox do |vb|
              vb.memory = node[:memory]
              vb.cpus = node[:cpu]
              
        end
    end

end

