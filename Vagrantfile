Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network :forwarded_port, host: 8080, guest: 80
  config.vm.network "private_network", ip: "192.168.14.4"
  config.vm.provision :shell, path: "bootstrap.sh"
end
