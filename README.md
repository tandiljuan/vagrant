Vagrant Environment
===================


Setup the Local Development Environment (LDE)
---------------------------------------------

This environment makes use of [Vagrant](http://www.vagrantup.com/) and [Berkshelf](http://berkshelf.com/). Follow the instructions to have the LDE up and running.

These instructions has been tested on a (GNU/Linux) [Ubuntu Trusty Tahr 64 bits](http://en.wikipedia.org/wiki/List_of_Ubuntu_releases#Ubuntu_14.04_LTS_.28Trusty_Tahr.29) OS.


### 1. Install [VirtualBox](https://www.virtualbox.org)

VirtualBox is an x86 virtualization software package developed by Sun Microsystems. Distributed under either the GNU GPL or a proprietary license with additional features.

Download and install **Virtualbox** and the **Extension Pack** from the [Virtualbox Downloads Page](https://www.virtualbox.org/wiki/Downloads).


### 2. Install Vagrant and plugins

Go to the [download](https://www.vagrantup.com/downloads.html) page, choose the correct package for your OS and install it. This instruction was written with the version [1.6.3](http://www.vagrantup.com/download-archive/v1.6.3.html) in mind.

    wget -c 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.3_x86_64.deb'
    sudo dpkg -i vagrant_1.6.3_x86_64.deb

Install Vagrant plugins

    # Berkshelf handle chef cookbooks dependencies
    vagrant plugin install vagrant-berkshelf --plugin-version ">= 2.0.1"
    # Omnibus ensures the desired version of Chef is installed in the guest
    vagrant plugin install vagrant-omnibus
    # Keep your VirtualBox Guest Additions up to date
    vagrant plugin install vagrant-vbguest
    # Automate bindfs mount in the VM
    vagrant plugin install vagrant-bindfs


### 3. Install Chef Development Kit

[Chef-DK](http://downloads.getchef.com/chef-dk/) include the `chef` command line tool and `berkshelf` (beside other tools). This instruction use the version 0.2.0-2.

    wget -c 'https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chefdk_0.2.0-2_amd64.deb'
    sudo dpkg -i chefdk_0.2.0-2_amd64.deb
    # https://github.com/berkshelf/vagrant-berkshelf/issues/212#issuecomment-51237580
    echo 'PATH=$HOME/.chefdk/gem/ruby/2.1.0/bin:/opt/chefdk/bin:$PATH' >> ~/.bashrc


### 4. Configuration files

Copy and edit the configuration files needed to run Vagrant.

    cp chef/berksfile/Berksfile.core Berksfile
    cp chef/roles/core.rb chef/roles_enabled/
    cp Vagrantfile.base Vagrantfile

Or execute the `init.sh` script to create the configuration files automatically.
Later you'll have to tune the files to your needs.

    ./init.sh -r core

### 5. Start (init) the VM with Vagrant

    vagrant up

**Note**: With `vagrant-vbguest` plugin and VirtualBox version 4.3.10, you could go through the next issue

    [default] Mounting shared folders...
    [default] -- /vagrant
    Failed to mount folders in Linux guest. This is usually beacuse
    the "vboxsf" file system is not available. Please verify that
    the guest additions are properly installed in the guest and
    can work properly. The command attempted was:

    mount -t vboxsf -o uid=`id -u vagrant`,gid=`getent group vagrant | cut -d: -f3` /vagrant /vagrant
    mount -t vboxsf -o uid=`id -u vagrant`,gid=`id -g vagrant` /vagrant /vagrant

The solution is to link VBoxGuestAdditions manually

    vagrant ssh --command 'sudo ln -s \
                           /opt/VBoxGuestAdditions-4.3.10/lib/VBoxGuestAdditions \
                           /usr/lib/VBoxGuestAdditions'
    vagrant reload


### 6. Update the system time zone

In the Vagrant machine, update the system timezone to the one that you are located.

    vagrant ssh
    sudo dpkg-reconfigure tzdata
    sudo service cron restart
