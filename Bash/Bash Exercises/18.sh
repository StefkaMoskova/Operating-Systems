#!/bin/bash

if [[ $(id -u) -ne 0 ]]; then
	echo "Must be executed by root"
	exit 1
fi

while read US HD; do
    if [[ -d "${HD}" ]]; then
        find ${HD} -type f -printf "${US} %T@ %p\n"
    fi
done < < (cat /etc/passwd | cut -d: -f1,6 | tr ":" "\t" | sort -k2 -rn | head -n1 | cut -d " " -f1,3)