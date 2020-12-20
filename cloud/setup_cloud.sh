#!/bin/bash

sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get -y install docker-ce
sudo usermod -aG docker $USER
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
sudo apt-get -y install git

cd ~/Documents
git clone https://github.com/ymakino/IoT_training.git
cp -ri ~/Documents/IoT_training/materials/efk ~/Desktop
mv ~/Documents/IoT_training /tmp

cat <<EOF > ~/Desktop/Kibana.desktop
[Desktop Entry]
Encoding=UTF-8
Name=Kibana
Type=Link
URL=http://cloud.local:5601/
Icon=text-html
EOF

cd ~/Desktop/efk
sg docker "docker-compose create"
