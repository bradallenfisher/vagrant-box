mkdir /media/VirtualBoxGuestAdditions
mount -r /dev/cdrom /media/VirtualBoxGuestAdditions

yum update kernel*
reboot

#after reboot uncomment these 
#rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
#yum install gcc kernel-devel kernel-headers dkms make bzip2 perl
#uname -r
## CentOS and Red Hat (RHEL) example ##
#KERN_DIR=/usr/src/kernels/2.6.18-194.11.1.el5-x86_64
## Export KERN_DIR ##
#export KERN_DIR
#cd /media/VirtualBoxGuestAdditions
#./VBoxLinuxAdditions.run
