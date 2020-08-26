#!/bin/bash

if [[ $# -ne 0 ]]; then 
	echo "Invalid number of arguments!"
	exit 1
fi

FIRST_ARG=$1
FLAG=0

if [[ ${FIRST_ARG} == "-n"]]; then
    SECOND_ARG=$2
    FLAG=1
    shift 2 #default: 1
fi

if [[ ${FLAG} -eq 1 ]]; then
    while [[ $# - gt 0 ]]; do 
        while read LINE; do
            echo "$( echo "${LINE}" | cut -d " " -f1,2) ${1} $(echo "${LINE}" | cut -d " " -f3-)"
        done < <(egrep '^[1-9][0-9]{3}-[0-9]{2}-[0-9]{2}[0-9]{2}:[0-9]{2}:[0-9]{2}.+$' ${1} | tail -n ${SECOND_ARG})
        shift 1
    done
fi

while [[$# -gt 0]]; do
    while read LINE; do
        echo "$( echo "${LINE}" | cut -d " " -f1,2) ${1} $(echo "${LINE}" | cut -d " " -f3-)"
    done < <(egrep '^[1-9][0-9]{3}-[0-9]{2}-[0-9]{2}[0-9]{2}:[0-9]{2}:[0-9]{2}.+$' ${1} | tail -n 10)
    shift 1
done