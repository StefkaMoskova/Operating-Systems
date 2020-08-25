#!/bin/bash

if [[ $# -ne 2 ]]; then 
	echo "Invalid number of arguments!"
	exit 1
fi

FIRST_FILE_LINES=$(grep -c $1)
SECOND_FILE_LINES=$(grep -c $2)

if [[ ${FIRST_FILE_LINES} -gt ${SECOND_FILE_LINES} ]]; then 
	FILENAME=$1
    cat $1 > $TEMP_FILE

else
    FILENAME=$2
    cat $2 > $TEMP_FILE
fi

cat $TEMP_FILE | cut -d " " -f4- | sort > $FILENAME.songs
# cat $TEMP_FILE | sed -E 's/^[0-9]{4}g.[[:alnum:]]{1,}-/g' | sort > $FILENAME.songs

rm -f $TEMP_FILE

