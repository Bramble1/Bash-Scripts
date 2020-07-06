#!/bin/bash

wget https://dl.suckless.org/dwm/dwm-6.2.tar.gz

tar xzvf dwm-6.2.tar.gz

cd dwm-6.2

for patch in ../patches/*.diff; do patch -p1 < "$patch"; done

