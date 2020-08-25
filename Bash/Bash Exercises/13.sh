#!/bin/bash

if [[ $# -ne 1 ]]; then
	echo "Invalid number of arguments"
	exit 1
fi

if [[ ! -d $1 ]]; then
	echo "${1} is not a directory!"
	exit 2
fi

#NB! finding broken symlinks
find -L $1 -type l 
