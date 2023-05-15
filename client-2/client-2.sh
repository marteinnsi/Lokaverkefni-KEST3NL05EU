 # Client-2 is a CentOS machine with the default Gnome desktop from installer
yum install rsyslog -y

# install postfix
yum install postfix

# set up ssh
ssh-keygen
ssh-copy-id -i ~/.ssh/id_rsa.pub mhugi@server1.dds.is
