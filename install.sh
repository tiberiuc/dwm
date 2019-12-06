#!/bin/bash


sudo apt-get install -y build-essential libx11-dev libxinerama-dev sharutils libpango1.0-dev
rm -rf ./tmp/

mkdir tmp

cd tmp

tar -xjvf ../src/dwm-6.0.tar.bz2

cd dwm-6.0

#git clone http://git.suckless.org/dwm

#cd dwm


diffs=`ls ../../src/git-diffs/*.diff`

for diff in $diffs
do
    echo
    echo "Applying git diff $diff"
    git am $diff
done

diffs=`ls ../../src/patch-diffs/*.diff`

for diff in $diffs
do
    echo
    echo "Applying patch $diff"
    patch -p1 < $diff
done

cp ../../src/config.def.h ./

make

sudo killall -9 dwm
sudo cp dwm /usr/bin/dwm.default
sudo cp dwm /usr/sbin/dwm
