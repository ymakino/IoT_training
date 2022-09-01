#!/bin/bash

ETH_IF=eth0

sudo apt-get -y install default-jre wireshark tcpdump telnet
sudo apt-get -y install iptables
sudo usermod -aG wireshark $USER

mkdir -p ~/.config/wireshark
cd ~/.config/wireshark
git clone https://github.com/mzyy94/ECHONET-Lite-dissector plugins

cd ~/Documents
git clone https://github.com/ymakino/IoT_training.git
cp -r ~/Documents/IoT_training/materials/humming/VirtualAC ~/Desktop/
cp -r ~/Documents/IoT_training/materials/humming/scripts ~/Desktop/
chmod +x ~/Desktop/run.sh ~/Desktop/scripts/*.sh ~/Desktop/scripts/*.py ~/Desktop/scripts/*/*.sh
mv ~/Documents/IoT_training `mktemp -d`

cat <<EOF > ~/Desktop/run.sh
#!/bin/sh
cd ${HOME}/Desktop/scripts

java -cp ${HOME}/Desktop/VirtualAC/VirtualAC.jar:${HOME}/Desktop/VirtualAC/lib/humming.jar humming.Humming -i ${ETH_IF}  bme280.xml lighting.xml VirtualAC.xml
EOF

cat <<EOF > ~/Desktop/run_with_dummy_sensor.sh
#!/bin/sh
cd ${HOME}/Desktop/scripts

java -cp ${HOME}/Desktop/VirtualAC/VirtualAC.jar:${HOME}/Desktop/VirtualAC/lib/humming.jar humming.Humming -i ${ETH_IF}  dummy_sensor/sensor.xml lighting.xml VirtualAC.xml
EOF

chmod +x ~/Desktop/run.sh
chmod +x ~/Desktop/run_with_dummy_sensor.sh
