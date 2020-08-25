#!/bin/bash

if [[ $(id -un) -ne 0 ]]; then 
	echo "Must be executed by the root user"
	exit 1
fi

if [[ $# -ne 1 ]]; then 
	echo "Invalid number of arguments"
	exit 2
fi

USERNAME=$1
USERS=$(ps -eo user | tail -n +2 | sort | uniq)
USERS_COUNT=$(ps -eo user | tail -n +2 | sort | uniq | wc -l)

grep -q ${username} < (ps -eo user | tail -n +2 | sort | uniq)

if [[ ! $? -ne 0 ]]; then 
	echo "Missing username"
	exit 3
fi

for i in ${USERS}; do
    if [[ $(ps -u ${USERNAME} | wc -l) -lt  $(ps -u ${i} | wc -l) ]]; then 
        echo "${i}"
    fi

    CURRENT_SUM=$(ps -u ${i} -eo etimes= | tr -d ' ' | tr -s '\n' '+' | rev | cut -c2- | bc)
    TOTAL_SUM=$((${CURRENT_SUM} + ${TOTAL_SUM}))
done

AVERAGE_TIME=$((${TOTAL_SUM} / ${USERS_COUNT}))
DOUBLE_AVERAGE_TIME=$((2*${AVERAGE-TIME}))

echo "AVERAGE TIME is ${TOTAL_SUM} / ${USERS_COUNT} = ${AVERAGE_TIME} ."

while read PID ELAPSED_TIME; do
    if [[ ${ELAPSED_TIME} -gt ${DOUBLE_AVERAGE_TIME} ]]; then 
        kill -s TERM ${PID}
        sleep 2
        kill -s KILL ${PID}
    fi
done < < (ps -u ${USERNAME} -eo pid, etimes)