# Create a RHEL 7 based vagrant base box from scratch with guest additions for VirtualBox 4.3 and vagrant 1.4+

- 1. Install VirtualBox
- 2. Install Vagrant

## Download This ISO

http://mirrors.kernel.org/centos/7/isos/x86_64/CentOS-7-x86_64-DVD-1503-01.iso 

or another one from

http://isoredirect.centos.org/centos/7/isos/x86_64/CentOS-7-x86_64-DVD-1503-01.iso

## Create the Virtual Box Image

- Open VirtualBox and click New.

- Give the virtual machine a Name: centos-7-x86_64.

- From the Type dropdown menu choose Linux.

- From the Version dropdown menu choose Red Hat (64 bit).

- Under Memory size, leave RAM at 512 MB (Vagrant can change this on-the-fly later).

- Under Hard drive, select Create a virtual hard drive now, and click Create.

- Under File location, leave the default name.

- Under File size, change the size to 40.00 GB.

- Under Hard drive file type, select VDI (VirtualBox Disk Image).

- Under Storage on physical hard drive, select Dynamically allocated, and click Create.

- The virtual machine definition has now been created. Click the virtual machine name and click Settings.

- Go to the Storage tab, click Empty just under Controller: IDE, then on the right hand side of the window click the CD icon, and select Choose a virtual CD/DVD disk file….

- Navigate to where the CentOS-6.7-x86_64-bin-DVD1.iso was downloaded, select it, and click Open.

- Go to the Audio tab and uncheck Enable Audio.

- Go to the Ports tab, then go to the USB subtab, and uncheck Enable USB Controller.

- Click Ok to close the Settings menu.

- Finally, start up the virtual machine to begin installation.

## Install CentOS 6.7
Just follow the prompts and install the OS. Make sure the root password is set to vagrant.

## Reboot and log in to the vm and type

```shell
nmtui
```

- Edit a Connection
- Make sure IPv4 is set to automatic
- Make sure there is an x in automatically connect
- save and exit

```
yum install -y openssh-clients man git vim wget curl ntp
```

## then add port forwarding to the NAT adapter from your local machine.

- From your MAC terminal run this command while the VM is running.

```shell
VBoxManage modifyvm "VM name" --natpf1 "guestssh,tcp,,2222,,22"
```

- ssh into the running vm with this command 

```shell
ssh -p 2222 root@127.0.0.1
```
## Once you are in copy and paste this one liner to handle the rest.

```shell
git clone https://github.com/bradallenfisher/vagrant-box.git && cd vagrant-box/rhel7 && chmod 700 install.sh && ./install.sh
```
## save the state of the box
- log into your VirtualBox terminal and type

```shell
shutdown -h now
```
###Remove the IDE from the VIRTUAL BOX INTERFACE
- in settings click the IDE and click the minus in the bottom corner.

## Now package the box
```shell
vagrant package --output centos-7-x86_64.box --base centos-7-x86_64
```
## Share it now at https://atlas.hashicorp.com/boxes/new or anywhere you want!!! ;)
