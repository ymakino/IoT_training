#!/bin/bash

# Install packages
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo usermod -aG docker $USER
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
sudo apt-get -y install git imagemagick wireshark mosquitto-clients
sudo usermod -aG wireshark $USER

# Install EFK environment
cd ~/Documents
git clone https://github.com/ymakino/IoT_training.git
cp -ri ~/Documents/IoT_training/materials/efk ~/Desktop
tar zxvf  ~/Documents/IoT_training/materials/controller.tar.gz -C ~/Desktop
mv ~/Documents/IoT_training `mktemp -d`

# Install Kibana.desktop
cat <<EOF > ~/Desktop/Kibana.desktop
[Desktop Entry]
Encoding=UTF-8
Name=Kibana
Type=Link
URL=http://cloud.local:5601/
Icon=text-html
EOF

# Create EFK images in advance
cd ~/Desktop/efk
sg docker "docker compose create"

# Setup the background picture
convert +antialias -font DejaVu-Sans -fill "#FFFFFF" -gravity SouthEast -pointsize 256 -annotate +128+64 Cloud /usr/share/backgrounds/warty-final-ubuntu.png ~/Pictures/ubg-cloud.png

echo gsettings set org.gnome.desktop.background picture-uri "file://`realpath ~/Pictures/ubg-cloud.png`"
gsettings set org.gnome.desktop.background picture-uri "file://`realpath ~/Pictures/ubg-cloud.png`"

echo gsettings set org.gnome.desktop.screensaver picture-uri "file://`realpath ~/Pictures/ubg-cloud.png`"
gsettings set org.gnome.desktop.screensaver picture-uri "file://`realpath ~/Pictures/ubg-cloud.png`"
