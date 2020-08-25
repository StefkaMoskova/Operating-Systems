#!/bin/bash

if [[ $# -ne 1 ]]; then 
	echo "Invalid number of arguments!"
	exit 1
fi

if [[ -e ${1} ]]; then 
	echo "${1} is not a file!"
	exit 2
fi

COUNTER=0
while read LINE; do
    COUNTER=$((${COUNTER}++))
    echo "${COUNTER}.${LINE}"
done < < (cat $1 | tr -s ' ' | cut -d ' ' -f4- | sort)