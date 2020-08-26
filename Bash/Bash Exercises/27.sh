#!/bin/bash

if [[ $# -ne 2 ]]; then 
	echo "Invalid number of arguments!"
	exit 1
fi

FILE1=$1
FILE2=$2

if [[ -e $FILE1 ]]; then 
	touch $FILE2
fi

while read NUMBER LINE; do
    if [[ ${NUMBER} -eq 1]]; then 
        grep "${LINE}" ${FILE1} >> ${FILE2}
    
    elif [[ ${NUMBER} -gt 1]]; then 
        grep "${LINE}" ${FILE1} | sort -n | head -n 1 >> ${FILE2}
    fi
done < <(sed 's/^[0-9]*//g' ${FILE1} | sort | uniq -c | tr -s ' ' | sed 's/^*//g')

