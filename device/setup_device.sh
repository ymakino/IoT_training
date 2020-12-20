#!/bin/bash

ETH_IF=eth0

sudo apt-get -y install default-jre

cd ~/Documents
git clone https://github.com/ymakino/IoT_training.git
mv ~/Documents/IoT_training /tmp

cp -r ~/Documents/IoT_training/materials/humming/VirtualAC ~/Desktop/
cp -r ~/Documents/IoT_training/materials/humming/scripts ~/Desktop/
chmod +x ~/Desktop/run.sh ~/Desktop/scripts/*.sh ~/Desktop/scripts/*.py

cat <<EOF > ~/Desktop/run.sh
#!/bin/sh
cd ${HOME}/Desktop/scripts

java -cp ${HOME}/Desktop/VirtualAC/VirtualAC.jar:${HOME}/Desktop/VirtualAC/lib/humming.jar humming.Humming -i ${ETH_IF}  bme280.xml lighting.xml VirtualAC.xml
EOF

chmod +x ~/Desktop/run.sh
