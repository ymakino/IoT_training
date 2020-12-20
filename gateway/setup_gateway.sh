#!/bin/bash

AREANET_IF=eno1

# Install packages
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install openjdk-8-jdk maven git

# Install NetBeans
cd /tmp
wget -c https://download.netbeans.org/netbeans/8.2/final/bundles/netbeans-8.2-javase-linux.sh 
chmod +x netbeans-8.2-javase-linux.sh 
./netbeans-8.2-javase-linux.sh 

# Install NetBeans Projects
mkdir ~/NetBeansProjects
cd ~/NetBeansProjects

git clone https://github.com/ymakino/echowand.git
git clone https://github.com/ymakino/echoMQTT.git
git clone https://github.com/ymakino/humming.git

# Build Paho Library
cd /home/user/NetBeansProjects/echoMQTT/lib && JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 sh ./build_paho.sh

# Open NetBeans
~/netbeans-8.2/bin/netbeans

# Add echowand and echoMQTT projects here
# Build echoMQTT here

# Prepare echoMQTT

cd ~/Documents
git clone https://github.com/ymakino/IoT_training.git
cp ~/Documents/IoT_training/materials/echoMQTT/rules.xml ~/Desktop
mv ~/Documents/IoT_training /tmp

# Prepare echoMQTT

cd ~/Desktop
cat <<EOF > run.sh
#!/bin/sh

java -jar ~/NetBeansProjects/echoMQTT/dist/echoMQTT.jar -i ${AREANET_IF} -b tcp://cloud.local:1883 ~/Desktop/rules.xml
EOF

chmod +x run.sh

sudo apt install wireshark mosquitto-clients zenmap
sudo usermod -aG wireshark $USER
