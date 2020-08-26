#!/bin/bash

if [[ $(id -un) -ne 0 ]]; then 
	echo "Must be executed by the root user"
	exit 1
fi

while read USER DIR; do
    if [[ ! -n ${DIR} ]]; then
        echo "The user doesn't have home directory"
        continue
    fi

    DIR_PERM=$(ls -ld ${DIR} | tr -s ' ' | cut -d ' ' -f1)
    DIR_OWNER=$(ls -ld ${DIR} | tr -s ' ' | cut -d ' ' -f3)

    if [[ ${DIR_OWNER} != ${USER} ]]; then
        echo "The user ${USER} is not the owner of his home directory"
    fi
done < <(cut -d: -f1,6 /etc/passwd | sort -t: -k1 | uniq | tr ':' ' ')
