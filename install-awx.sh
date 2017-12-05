# bootstrap for centos7 minimal
# -persistent /data expected

yum install -y yum-utils

yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

yum-config-manager --enable docker-ce-edge

yum install -y docker-ce docker-python ansible git \
  cockpit-dashboard cockpit-docker cockpit-selinux \
  cockpit-storaged cockpit-system cockpit-bridge \
  cockpit-ws epel-release

systemctl enable docker
systemctl enable cockpit

systemctl start docker
systemctl start cockpit

if [ ! -f /data ]; then
  mkdir /data
fi

cd /data

git clone https://github.com/ansible/awx.git

sed -i 's!/tmp/pgdocker!/data/pgdocker!' awx/installer/inventory

ansible-playbook -v -i awx/installer/inventory awx/installer/install.yml


systemctl enable firewalld
systemctl start firewalld

firewall-cmd --add-service=http
firewall-cmd --add-service=http --permanent
firewall-cmd --add-service=cockpit
firewall-cmd --add-service=cockpit --permanent

yum update -y

echo "rebooting"
reboot
