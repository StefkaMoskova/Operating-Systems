#!/bin/bash

if [[ $# -ne 1]]; then
    find -L $1 -type l 2>/dev/null

elif [[ $# -ne 2 ]]; then
    for i in $(find $1 -type f); do
        if [[ $(find $1 -type f -name "${i}" -printf '%n\n' ) -ge $2 ]]; then
            echo "${i}"
        fi
    done

else
    echo "Invalid number of args"
    exit 1
fi