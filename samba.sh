#!/bash/bin
user=xwj
samba_passwd=xwjs

sudo yum install -y samba
sudo yum install -y samba-client

# or
# sudo apt update
# sudo apt install -y samba
# sudo apt install -y samba-client

# check the firewalld
# systemctl status firewalld
# systemctl status firewalld.service

sudo systemctl stop firewalld.service
sudo systemctl disable firewalld.service

sudo echo "SELINUX=disabled" >>/etc/selinux/config

share_dir=win_linux
mkdir -p ~/$share_dir
sudo chmod 777 ~/$share_dir

sudo echo "[win_linux]" >>/etc/samba/smb.conf
sudo echo "comment = my share" >>/etc/samba/smb.conf
sudo echo "path = $share_dir" >>/etc/samba/smb.conf
sudo echo "public = yes" >>/etc/samba/smb.conf
sudo echo "writable = yes" >>/etc/samba/smb.conf
sudo echo "browseable = yes" >>/etc/samba/smb.conf
sudo echo "guest ok = yes" >>/etc/samba/smb.conf
sudo echo "guest only = yes" >>/etc/samba/smb.conf
sudo echo "read only = no" >>/etc/samba/smb.conf

sudo smbpasswd -a $user
sudo systemctl start smb.service
sudo systemctl start nmb.service

sudo systemctl enable smb.service
sudo systemctl enable nmb.service
