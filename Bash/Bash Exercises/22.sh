#!/bin/bash

if [[ $# -eq 0 ]]; then 
	echo "Invalid number of arguments"
	exit 1
fi

DIR="${1}"

if [[ ! -d "${DIR}" ]]; then
	echo "${DIR} is not a directory"
	exit 2
fi

function PROCESS_SYMLINKS {
	while read SRC DST; do
		if [[ -e "${DST}" ]]; then
			echo "${SRC} -> ${DST}"
		fi
	done < <(ls "${DIR}" -la | grep '->' | tr -s ' ' | cut -d ' ' -f 9,10,11 | sed 's/->//g' | tr -s ' ')
	echo "Broken symlinks: $(find -L "${DIR}" -type l 2>/dev/null | wc -l)"
}


if [[ $# -eq 1 ]]; then
	PROCESS_SYMLINKS "${DIR}"

elif [[ $# -eq 2 ]]; then
	FILE="${2}"

    if [[ ! -f "${FILE}" ]]; then
	    echo "${FILE} is not a file"
	    exit 2
    fi

	if [[ -e "${FILE}" ]]; then
		PROCESS_SYMLINKS "${DIR}" > "${FILE}"
	else
		echo "FILE: "${FILE}" doesn't exist!"
	fi
    
else 
	echo "Invalid number of arguments!"
fi