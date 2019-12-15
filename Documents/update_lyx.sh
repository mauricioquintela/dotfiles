#!/bin/sh

local=$(pwd)
cd ~/HDD/git/lyx/
git pull origin master
./autogen.sh
./configure
make -j4
sudo make -j4 install
cd $local
