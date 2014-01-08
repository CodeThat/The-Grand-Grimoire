#!/bin/bash

### regexp for IP search (first octect of IP addresses should be sufficient) ###
### to search multiple subnets use the infix operator |  such as:
#IPSEARCH="147|64"
IPSEARCH="94.125.248.43";
#IPv6 use the first few digits like so...
#IPSEARCH="2001:5c0";
 
### colors ###
#title color
COL1="\x1b[0;31;40m";
#ip color
COL2="\x1b[0;32;40m";
#'=' color
COL3="\x1b[0;34;40m";
#domain color
COL4="\x1b[0;33;40m";
#error color
COL5="\x1b[0;31;40m";
#colors off (back to natural terminal colors)
COLOFF="\x1b[0;37;00m";
 
### footer (Displayed at end of list) ###
FOOTER="Enjoy!"
 
### Command paths ###
IFCONFIG="/sbin/ifconfig";
GREP="/bin/grep";
AWK="/usr/bin/awk";
HOST="/usr/bin/host";
 
##################
#Code goes here
##################
 
HOSTNAME=`hostname`;
echo -en "$COL1 Hostnames for $HOSTNAME\n";
for tip in `$IFCONFIG | $GREP inet | $AWK '{print $2}' | $GREP -E "$IPSEARCH"`;
do
  IFS=":"
  zip=($tip);
  ip=${zip[1]};
  echo -ne "$COL2$ip $COL3=";
  if hostreply=`$HOST $ip`; then
    domain=`echo $hostreply | $GREP domain | $AWK '{print $5}'`;
    if fwdreply=`$HOST -t A $domain`; then
      forward=`echo "$fwdreply" | $AWK '{print $4}'`;
      if [ "$forward" = "$ip" ]; then
        error="";
      else
        error="$COL5(Forward lookup mismatch: $forward)";
      fi
    else
      error="$COL5(forward does not resolve)";
    fi
    echo -ne "$COL4 $domain $error\n";
  else
    echo -ne "$COL5 reverse lookup failed ._.\n";
  fi
done
 
echo -ne "$COLOFF\n";
if [ -n "$FOOTER" ]; then
  echo $FOOTER
fi
