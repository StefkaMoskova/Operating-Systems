#!/bin/bash

if [[ $(id -u) -ne 0 ]]; then
	echo "Must be executed by root"
	exit 1
fi

function total_rss{
    sum=0
    while read RSS; do
        sum=$((${sum} + ${RSS}))
    done< < (ps -u $1 -eo rss)
    echo "$sum"
}

users=$(ps -eo user | grep -v root| tail -n +2 | sort | uniq)
for i in ${users}; do
    homedir=$(grep ${i} | cut -d: -f6)
    if [[ (! -d ${homedir}) || $(stat -c '%U' ${homedir}) != ${i} || $(stat -c '%A' ${homedir} | cut -c3) != 'w' ]]; then
        if [[ $(total_rss ${i}) -gt $(total_rss root)]]; then
            echo "All processes for user ${i} will be killed"
            pkill -u ${i}
        fi
    fi
done

