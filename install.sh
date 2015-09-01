#!/bin/bash

chkconfig ntpd on

service ntpd stop
ntpdate time.nist.gov
service ntpd start

chkconfig sshd on

chkconfig iptables off
chkconfig ip6tables off

sed -i -e 's/^SELINUX=.*/SELINUX=permissive/' /etc/selinux/config

useradd vagrant

mkdir -m 0700 -p /home/vagrant/.ssh

curl https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub >> /home/vagrant/.ssh/authorized_keys

chmod 600 /home/vagrant/.ssh/authorized_keys

chown -R vagrant:vagrant /home/vagrant/.ssh

sed -i 's/^\(Defaults.*requiretty\)/#\1/' /etc/sudoers

echo "vagrant ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

cat << EOF1 > /etc/sysconfig/network-scripts/ifcfg-eth0
DEVICE=eth0
TYPE=Ethernet
ONBOOT=yes
NM_CONTROLLED=no
BOOTPROTO=dhcp
EOF1

rm -f /etc/udev/rules.d/70-persistent-net.rules

yum clean all

rm -rf /tmp/*

rm -f /var/log/wtmp /var/log/btmp

rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
yum install gcc kernel-devel kernel-headers dkms make bzip2 perl -y
yum install kernel-devel-2.6.32-573.el6.x86_64 -y
wget http://download.virtualbox.org/virtualbox/5.0.0_RC3/VBoxGuestAdditions_5.0.0_RC3.iso
sudo mkdir /media/VBoxGuestAdditions
sudo mount -o loop,ro VBoxGuestAdditions_5.0.0_RC3.iso /media/VBoxGuestAdditions
sudo sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
rm VBoxGuestAdditions_5.0.0_RC3.iso -rf
sudo umount /media/VBoxGuestAdditions
sudo rmdir /media/VBoxGuestAdditions
