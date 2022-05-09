#!/bin/bash

AREANET_IF=eno1
NETBEANS_VERSION=13

# Install packages
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install default-jdk maven git
sudo apt -y install wireshark mosquitto-clients zenmap
sudo usermod -aG wireshark $USER

# Install NetBeans
cd /tmp
wget -c https://ftp.jaist.ac.jp/pub/apache/netbeans/netbeans-installers/${NETBEANS_VERSION}/Apache-NetBeans-${NETBEANS_VERSION}-bin-linux-x64.sh 
echo sh Apache-NetBeans-${NETBEANS_VERSION}-bin-linux-x64.sh  --silent
sh Apache-NetBeans-${NETBEANS_VERSION}-bin-linux-x64.sh  --silent
sed -i -e 's|^netbeans_jdkhome=.*$|netbeans_jdkhome="/usr/lib/jvm/default-java"|' ~/netbeans-${NETBEANS_VERSION}/netbeans/etc/netbeans.conf

# Install NetBeans Projects
mkdir ~/NetBeansProjects
cd ~/NetBeansProjects

git clone https://github.com/ymakino/echowand.git
git clone https://github.com/ymakino/echoMQTT.git
git clone https://github.com/ymakino/humming.git

# Build Paho Library
cd ~/NetBeansProjects/echoMQTT/lib && JAVA_HOME=/usr/lib/jvm/default-java sh ./build_paho.sh

# Open NetBeans
echo
echo Open echowand and echoMQTT projects
echo Build echoMQTT
echo Then quit NetBeans
~/netbeans-${NETBEANS_VERSION}/netbeans/bin/netbeans

# Prepare echoMQTT
cd ~/Documents
git clone https://github.com/ymakino/IoT_training.git
cp ~/Documents/IoT_training/materials/echoMQTT/rules.xml ~/Desktop
mv ~/Documents/IoT_training `mktemp -d`

# Prepare echoMQTT
cd ~/Desktop
cat <<EOF > run.sh
#!/bin/sh

java -jar ~/NetBeansProjects/echoMQTT/dist/echoMQTT.jar -i ${AREANET_IF} -b tcp://cloud.local:1883 -u mosquitto -p secret ~/Desktop/rules.xml
EOF

chmod +x run.sh

# Add ECHONET Lite dissector
mkdir -p ~/.config/wireshark
cd ~/.config/wireshark
git clone https://github.com/mzyy94/ECHONET-Lite-dissector plugins

# Setup the background picture
convert +antialias -font DejaVu-Sans -fill "#FFFFFF" -gravity SouthEast -pointsize 256 -annotate +128+64 Gateway /usr/share/backgrounds/warty-final-ubuntu.png ~/Pictures/ubg-gateway.png

echo gsettings set org.gnome.desktop.background picture-uri "file://`realpath ~/Pictures/ubg-gateway.png`"
gsettings set org.gnome.desktop.background picture-uri "file://`realpath ~/Pictures/ubg-gateway.png`"

echo gsettings set org.gnome.desktop.screensaver picture-uri "file://`realpath ~/Pictures/ubg-gateway.png`"
gsettings set org.gnome.desktop.screensaver picture-uri "file://`realpath ~/Pictures/ubg-gateway.png`"
