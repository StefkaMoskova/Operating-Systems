#!/bin/bash

if [[ $# -ne 1 ]]; then 
	echo "Invalid number of arguments!"
	exit 1
fi

if [[ -d ${1} ]]; then 
	echo "Directory ${1} does not exist!"
	exit 2
fi

declare -A arr

friends=$(find ${1} -maxdepth 3 -mindepth 3 -type d)

for i in ${friends}; do
    key=$(basename ${i})
    lines=$(find ${i} -type f -name '????-??-??-??-??-??.txt' | xargs cat | wc -l)
    arr[${key}]=$((${arr[${key}] : -0} + ${lines}))
done