#!/bin/bash

status=$(stat $0 --printf "%X\n")

while read path time
do
	if [[ $status -lt $time  ]]
	then
		tar -xvf "$path" "./temp"
		cur= $(find ./temp -name "meow.txt" )
		if [[ $cur != ""  ]]
		then
		       mv "./moew.txt" "/extracted/$path\_$time"  	
		fi
			
	fi
done < <(find $1 -type f -name "[^_]+_report-[0-9]+.tgz" -printf "%p %T@"|sort -t " " -k 1|uniq)