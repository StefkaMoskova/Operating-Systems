#!/bin/bash

if [[ $# -ne 2 ]]; then
	echo "Invalid number or arguments"
	exit 1
fi

if [[ ! -d $1 ]]; then
	echo "${1} is not a directory"
	exit 2
fi

DIR=${1}
STRING=${2}

LONGNAME=$(find "${DIR}" -mindepth 1 -type f -name "vmlinuz-*.*.*-${STRING}" | sort -V | tail -n 1)
# MORE SUITABLE REGULAR EXPRESSION WOULD BE: 
# LONGNAME=$(find "${DIR}" -mindepth 1 -type f -name "vmlinuz-[0-9]+\.[0-9]+\.[0-9]+-${STRING}" | sort -V | tail -n 1)

BASENAME "${LONGNAME}"

