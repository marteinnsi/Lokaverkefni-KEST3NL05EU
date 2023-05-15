# Client-1 is a Ubuntu machine
# install rsyslog
apt install rsyslog -y

# install postfix
apt install postfix

# set up ssh
ssh-keygen

ssh-copy-id -i ~/.ssh/id_rsa.pub mhugi@server1.dds.is
