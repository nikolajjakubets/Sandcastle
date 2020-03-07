#!/bin/sh
Cd ~/Documents/iDroid
rm -rf checkra1n.app
rm -rf __MACOSX
unzip checkra1n.app.zip
rm -rf __MACOSX
mv checkra1n.app /Applications
cd /Applications/checkra1n.app/Contents/MacOS
./checkra1n -c -V