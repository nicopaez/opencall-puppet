#!/bin/sh

# necessary stuff to get puppet up and running before we can do the rest of the setup
# expects the FQDN of the host as the first argument

if [ ! -e /etc/_FIRST_BOOT ]; then

    #sudo apt-get install --yes puppet
	#	sudo apt-get install unzip

    # frig /etc/hosts on first boot. /etc/hostname is set correctly by Vagrant
    # but without this extra step, we get a factor error when puppet runs

    echo "cat >/etc/hosts <<EOL
127.0.0.1   localhost
# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
EOL" | sudo -s
    sudo puppet module install puppetlabs-java
    sudo puppet module install puppetlabs/stdlib
    sudo puppet module install puppetlabs/git
    sudo puppet module install maestrodev/rvm
    sudo puppet module install elasticsearch/elasticsearch
    sudo puppet module install puppetlabs/postgresql
    sudo apt-get install -y build-essential
    curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
    sudo apt-get install -y nodejs
    sudo touch /etc/_FIRST_BOOT
fi
