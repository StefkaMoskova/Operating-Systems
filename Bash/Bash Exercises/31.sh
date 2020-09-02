#!/bin/bash

touch bar.csv
chmod 666 bar.csv

count=0

echo "hostname, phy, vlans, hosts, failover, VPN-3DES-AES, peers, VLAN Trunk Ports, license, SN, key" > bar.csv

while read file; do

	while read line; do
		
	if [[ $line == "" ]]; then
		continue
	fi

	if [[ $count -eq 0  ]]; then
		count=$($count + 1)
		name=$(echo $file|cut -d"." -f1)
		echo "$name" >> bar.csv
	fi

	if [[ $line =~ ":" ]]; then
		if [[ $(echo $line | cut -d":" -f2) == "" ]]; then
				cur=$(echo $line | sed "s/This plat has [an,a]/:/g")
        fi

		cur=$(echo $line | cut -d":" -f2|tr  " " ",")
		echo "$cur" >> bar.csv 
	fi
done < <(cat $file)

done < <(ls $2 "*.log"|tr " " "\n" )
