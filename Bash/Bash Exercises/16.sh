#!/bin/bash

LINE1=$(egrep "^${2}=" $1 | cut -d= -f2)

if [[ $(egrep -c "^${3}=") -eq 0 ]]; then 
    echo "${3}=" >> $1
    exit 0
fi

LINE2=$(egrep "^${3}=" ${1} | cut -d= -f2)
NEW2=$(comm -13 < (echo "^${LINE1}" | tr -s ' ' | tr ' ' '\n' | sort) < (echo "${LINE2}" | tr -s ' ' | tr ' ' '\n' | sort) | xargs)

sed -i -e "s/^${3}=${LINE2}/${3}=${NEW2}/g" ${1}