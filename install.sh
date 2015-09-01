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

history -c
