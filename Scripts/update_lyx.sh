#!/bin/sh

local=$(pwd)
cd ~/HDD/git/lyx/
git pull origin master
./autogen.sh
./configure
make -j4
notify-send -t 10000 "PASSWORD REQUIRED"
sudo make -j4 install
cd $local
