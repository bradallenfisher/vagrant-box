#!/bin/bash

ntpdate time.nist.gov
systemctl start ntpd.service
systemctl enable ntpd.service
systemctl is-enabled ntpd.service

systemctl enable sshd.service

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

cat << EOF1 > /etc/sysconfig/network-scripts/ifcfg-enp0s3
TYPE=Ethernet
BOOTPROTO=dhcp
DEFROUTE=yes
PEERDNS=yes
PEERROUTES=yes
NAME=enp0s3
DEVICE=enp0s3
ONBOOT=yes
EOF1

rm -f /etc/udev/rules.d/70-persistent-net.rules
yum -y update
yum clean all

rm -rf /tmp/*

rm -f /var/log/wtmp /var/log/btmp

rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
yum install gcc kernel-devel kernel-headers dkms make bzip2 perl -y
yum install kernel-devel-3.10.0-229.el7.x86_64 -y
wget http://download.virtualbox.org/virtualbox/4.3.30/VBoxGuestAdditions_4.3.30.iso
sudo mkdir /media/VBoxGuestAdditions
sudo mount -o loop,ro VBoxGuestAdditions_4.3.30.iso /media/VBoxGuestAdditions
sudo sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
rm VBoxGuestAdditions_4.3.30.iso -rf
sudo umount /media/VBoxGuestAdditions
sudo rmdir /media/VBoxGuestAdditions
