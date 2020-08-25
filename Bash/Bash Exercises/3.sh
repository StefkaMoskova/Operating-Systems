#!/bin/bash

mkdir a b c 

for i in $(find . -maxdepth 1 -type f); do
    COUNTER=$(wc -l < ${i})
    if [[ ${COUNTER} -lt $1]]; then
        mv ${i} ~/a
    elif [[ ${COUNTER} -lt $2]]; then
        mv ${i} ~/b
    else
        mv ${i} ~/c
    fi
done