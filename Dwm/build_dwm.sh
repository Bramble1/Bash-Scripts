#!/bin/bash


#install depedencies
sudo apt-get install -y libx11-dev libxft-dev libxinerama-dev

wget https://dl.suckless.org/dwm/dwm-6.2.tar.gz

tar xzvf dwm-6.2.tar.gz

rm *.gz

cd dwm-6.2


sed -i 's,FREETYPEINC = ${X11INC}/freetype2,#FREETYPEINC = ${X11INC}/freetype2,g' config.mk
sudo make install


mv dwm /usr/bin


echo "dwm" >  /home/sam/.xinitrc

#for patch in ../patches/*.diff; do patch -p1 < "$patch"; done


