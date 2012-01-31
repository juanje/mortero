# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "base"

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
  
    # You may also specify custom JSON attributes:
    #chef.json = { :mysql_password => "foo" }
  end
end
