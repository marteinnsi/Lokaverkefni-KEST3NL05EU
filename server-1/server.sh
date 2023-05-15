# update
yum update -y

# set hostname
hostnamectl set-hostname server1

# set static ip address and set dns
echo "TYPE=Ethernet
BOOTPROTO=static
NAME=enp0s8
DEVICE=enp0s8
ONBOOT=yes
IPADDR=192.168.100.254
NETMASK=255.255.255.0
DNS1=8.8.8.8
DNS2=8.8.4.4" > /etc/sysconfig/network-scripts/ifcfg-enp0s8

# update hosts
echo "$(hostname -I) server1.ddp.is server1" >> /etc/hosts

# restart network service
systemctl restart network

#-- At this point, $(hostname)=server1 and $(hostname -f)=server1.ddp.is
#-- The server also has a static ip address, 192.168.100.254 the last address in block 192.168.100.0/24


# install dhcp
yum install dhcp -y

# configure dhcpd
echo "subnet 192.168.100.0 netmask 255.255.255.0 {
    range 192.168.100.1 192.168.100.200;
    option domain-name-servers 8.8.8.8, 8.8.4.4;
    option domain-name \"server1.ddp.is\";
}" > /etc/dhcp/dhcpd.conf

# restart and enable dhcpd
systemctl restart dhcpd
systemctl enable dhcpd

#-- Now, Client-1 on Ubuntu adapter enp0s8 connects to the DHCP server automatically
#-- and is assigned the ip address 192.168.100.1 as seen in logs (systemctl status dhcpd)
#-- same with Client-2 on CentOS Gnome but it has ip 192.168.100.2


# create users from csv input

groupadd {tolvudeild,rekstrardeild,framkvaemdadeild,framleidsludeild}


cat Linux_Users.CSV | ./create-users.sh

# install mysql. i went for mariadb as it is compatible with mysql and doesnt require a lot of extra work to get on centos
yum install mariadb-server -y

systemctl start mariadb.service

# i had to do this, no idea how you would "script" this like ive been trying to do things
# but i entered new passwords, etc.
mysql_secure_installation

# then you can run script create-db.sql
todo

#-- Now I will set up the cron task
# I didnt know how to do the backup but this one just copies the /home directory into an archive in the root directory
# this is pointless as they are on the same partition but in a real scenario it might be uploaded somewhere else, or at least put on a different drive. This task runs every friday at midnight.
echo "0 0 * * 5 tar -czf /Home_$(date).tar.gz /home" | crontab -

#-- 8. install ntp
# couldnt figure more out
yum install ntp -y
systemctl start ntpd
systemctl enable ntpd
#-- 9. syslog
yum install rsyslog -y
systemctl start rsyslog
systemctl enable rsyslog


#-- 10. postfix
yum install postfix -y

# set inet_interfaces = all


systemctl start postfix
systemctl enable postfix


# -- 12. ssh
yum install openssh-server -y
# /etc/sshd_config is edited, password auth is disabled
#>PasswordAuthentication no

