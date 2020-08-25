#!/bin/bash

if [[ $(id -u) -ne 0 ]]; then
	echo "Must be executed by root"
	exit 1
fi

if [[ $# -ne 3 ]]; then 
	echo "Invalid number of arguments"
	exit 2
fi

if [[ ! -d ${1} ]]; then 
	echo "${1} is not a directory"
	exit 3
fi

if [[ ! -d ${2} ]]; then 
	echo "${2} is not a directory"
	exit 4
fi

if [[ $(find $2 -type f | wc -l) -ne 0 ]]; then 
	echo "${2} is not empty"
	exit 5
fi

for i in $(find $1 -type f -name "*$3*"); do
    DIR=$(dirname ${i})
    FILENAME=$(basename ${i})

    if [[ $(echo ${i}) == "${1}/${FILENAME}" ]]; then 
	    mv ${i} "${2}/${FILANAME}"
    
    else 
        DIR2=$(echo ${DIR} | sed -e "s/${1}/${2}/")
        mkdir -p "${DIR2}"
        mv ${i} "${DIR2}/${FILANAME}"
    fi
done

