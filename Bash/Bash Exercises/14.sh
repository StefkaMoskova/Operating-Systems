#!/bin/bash

if [[ $# -ne 1 ]]; then 
	echo "Invalid number of arguments!"
	exit 1
fi

if [[ $(id -un) -ne 0 ]]; then 
	echo "Must be executed by the root user"
	exit 2
fi

USERS=$(ps -eo user | tail -n +2 | sort | uniq)

for i in ${USERS}; do
    SUM=0
    MAX_RSS=0
    PID_WITH_MAX_RSS=0

    while read RSS PID; do
        SUM=$((${SUM} + ${RSS}))
        if [[ ${RSS} -gt ${MAX_RSS} ]]; then 
	        MAX_RSS=${RSS}
            PID_WITH_MAX_RSS=${PID}
        fi
    done < < (ps -u ${i} -eo rss, pid | tail -n +2)

    if [[ ${SUM} -gt ${1} ]]; then 
	        kill -9 ${PID_WITH_MAX_RSS}
    fi
    
done