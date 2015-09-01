#!/bin/bash
rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
yum install gcc kernel-devel kernel-headers dkms make bzip2 perl
wget http://download.virtualbox.org/virtualbox/5.0.0_RC3/VBoxGuestAdditions_5.0.0_RC3.iso
sudo mkdir /media/VBoxGuestAdditions
sudo mount -o loop,ro VBoxGuestAdditions_5.0.0_RC3.iso /media/VBoxGuestAdditions
sudo sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
rm VBoxGuestAdditions_5.0.0_RC3.iso
sudo umount /media/VBoxGuestAdditions
sudo rmdir /media/VBoxGuestAdditions
