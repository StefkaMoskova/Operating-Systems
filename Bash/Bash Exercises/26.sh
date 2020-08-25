#!/bin/bash

if [[ $# -ne 2 ]]; then 
	echo "Invalid number of arguments!"
	exit 1
fi

FILE="${1}"
DIR="${2}"

if [[ -e "${FILE}" ]]; then 
	echo "File ${FILE} does not exist!"
	exit 2
fi

if [[ -d "${DIR}" ]]; then 
	echo "Directory ${DIR} does not exist!"
	exit 3
fi

NUMBER=0
while read NAME; do	
	echo "${NAME};$((NUMBER++))" >> "${DIR}"/dict.txt 
	egrep '^[A-Za-z]+ [A-Za-z]+((:)? | (\([A-Za-z]+ [A-Za-z]+\))?:) {0,}.*$' "${FILE}" | egrep "${NAME}" | cut -d ':' -f2 >> "${DIR}"/"${NUMBER}".txt
done< <(egrep '^[A-Za-z]+ [A-Za-z]+((:)? | (\([A-Za-z]+ [A-Za-z]+\))?:) {0,}.*$' "${FILE}"| egrep -o '^[A-Za-z]+ [A-Za-z]+' | sort | uniq )