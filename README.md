Vagrant Environment
===================

# Setup the Local Development Environment (LDE)

This environment makes use of [Vagrant](http://www.vagrantup.com/) and [Berkshelf](http://berkshelf.com/). Follow the instructions to have the LDE up and running.

These instructions has been tested on a (GNU/Linux) [Ubuntu Precise Pangolin](http://en.wikipedia.org/wiki/List_of_Ubuntu_releases#Ubuntu_12.04_LTS_.28Precise_Pangolin.29) OS.

### 1. Install rbenv and ruby-build

Based on [this instructions](https://gist.github.com/2627011) and [this instructions](http://www.stehem.net/2012/05/08/how-to-install-ruby-with-rbenv-on-ubuntu-12-04.html).

If you have ruby and gems already installed trough apt, you'll need to remove them.

```sh
# Example of how to remove installed gems
# http://stackoverflow.com/a/4907690
for x in `gem list --no-versions`; do gem uninstall $x -a -x -I; done
# Example of how to remove installed ruby
sudo apt-get autoremove libruby1.8 libruby1.9.1 rbenv ruby ruby1.8 ruby1.8-dev ruby1.9.1 rubygems
```

##### Install dependencies

```sh
sudo apt-get install build-essential git-core libreadline-dev libssl-dev openssl zlib1g-dev
```

##### Install [rbenv](https://github.com/sstephenson/rbenv)

```sh
cd
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL
```

##### Install [ruby-build](https://github.com/sstephenson/ruby-build)

```sh
mkdir -p ~/.rbenv/plugins
cd ~/.rbenv/plugins
git clone git://github.com/sstephenson/ruby-build.git
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL
```

### 2. Install [Ruby 1.9.3-p448](https://www.ruby-lang.org/en/news/2013/06/27/ruby-1-9-3-p448-is-released/)

```sh
rbenv install 1.9.3-p448
```

Rehash after each Ruby and gem installation

```sh
rbenv rehash
```

Set Ruby 1.9.3-p448 as your default Ruby version

```sh
rbenv global 1.9.3-p448
```

### 3. Install [Bundler](http://bundler.io/) (dependency resolution)

```sh
gem install --no-rdoc --no-ri bundler --version "=1.3.5"
# Don't forget to rehash
rbenv rehash
```

### 4. Install Berkshelf

Berkshelf is a tool to manage Chef Cookbooks (dependency resolution and cookbook fetching)

```sh
gem install --no-rdoc --no-ri berkshelf --version "=2.0.7"
rbenv rehash
```

### 5. Install [VirtualBox](https://www.virtualbox.org)

VirtualBox is an x86 virtualization software package developed by Sun Microsystems. Distributed under either the GNU GPL or a proprietary license with additional features.

Download Virtualbox from the [Virtualbox Downloads Page](https://www.virtualbox.org/wiki/Downloads) and then install it.

### 6. Install Vagrant

Go to de [download](http://downloads.vagrantup.com/) page, choose the correct package for your OS and install it. This instruction was written with the version [1.2.2](http://downloads.vagrantup.com/tags/v1.2.2) in mind.

### 7. Install the Berkshelf plugin for Vagrant

```sh
vagrant plugin install vagrant-berkshelf
```

### 8. Start (init) the VM with Vagrant

```sh
vagrant up
```


## Login into the VM


```sh
vagrant ssh
```

### Update the system time zone

In the Vagrant machine, update the system timezone to the one that you are located.

```sh
sudo dpkg-reconfigure tzdata
sudo service cron restart
```
