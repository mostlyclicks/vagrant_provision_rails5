#!/bin/bash
# See also: 
# * https://gorails.com/setup/ubuntu/14.04
# * https://rvm.io
# * http://www.postgresql.org/download/linux/ubuntu

sudo su

echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

apt-get update
apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libpq-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties
apt-get -y install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
apt-get -y install imagemagick
apt-get -y install nodejs
apt-get -y install postgresql-9.4
apt-get -y install ruby1.9.1-dev

command curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -sSL https://get.rvm.io | bash -s stable

source /home/vagrant/.rvm/scripts/rvm

rvm install 2.4.2
rvm use 2.4.2 --default

echo "gem: --no-ri --no-rdoc" > ~/.gemrc

gem install rails -v 5.1.4

echo "-------------------- creating postgres vagrant role with password vagrant"
# Create Role and login
sudo su postgres -c "psql -c \"CREATE ROLE vagrant SUPERUSER LOGIN PASSWORD 'vagrant'\" "

sudo su postgres -c "createdb -O vagrant -Eutf8 vagrant_development"