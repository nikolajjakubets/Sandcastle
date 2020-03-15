#!/bin/bash
cd ~/Documents/iDroid/BootDroid
chmod 777 iproxy
chmod 777 libusbmuxd.4.dylib
chmod 777 libplist.3.dylib
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"
export DYLD_LIBRARY_PATH=./
killall -9 iproxy  > /dev/null 2>&1
./iproxy 2222 44 > /dev/null 2>&1 &
disown

echo "Starting setup"
expect -c 'spawn scp -P2222 -o StrictHostKeyChecking=no isetup root@localhost:/tmp/setup.sh;  expect "password:" { send "alpine\r" } "lost connection" { exit 1 };interact' >/dev/null 2>&1
if [ $? -ne 0 ]; then
	echo "Failed to copy setup script";
	killall -9 iproxy
	exit 1;
fi

expect -c 'spawn ssh -oStrictHostKeyChecking=no -p2222 root@localhost "chmod 755 /tmp/setup.sh && /tmp/setup.sh"; expect "password:" { send "alpine\r" } "ssh: connect" { exit 1 }; interact; catch wait result; exit [lindex $result 3]'
if [ $? -ne 0 ]; then
	echo "Setup failed";	
	killall -9 iproxy;
	exit 1;
fi
echo "Setup was successful";
killall -9 iproxy  > /dev/null 2>&1
