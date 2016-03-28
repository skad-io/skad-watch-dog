sudo apt-get -y install libssl-dev
sudo apt-get -y install cpanminus
cpanm JSON
cpanm LWP::Simple
cpanm LWP::Protocol::https

# This one will prompt and ask you to press enter - need to try and find a way to automate this
#perl -MCPAN -e'install "LWP::Simple"'
# - Just gonna try everything with cpanm and see how it pans out on next full install

