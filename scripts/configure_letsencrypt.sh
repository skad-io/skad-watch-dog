apt-get -y install git bc

git clone https://github.com/letsencrypt/letsencrypt /opt/letsencrypt

/opt/letsencrypt-auto --dry-run certonly --standalone -d scottshouse.redirectme.net
