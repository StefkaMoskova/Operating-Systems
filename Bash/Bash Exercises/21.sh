#!/bin/bash

if [[ $(id -u) -ne 0 ]]; then
	echo "Must be executed by root"
	exit 1
fi

USERS=$(ps -eo user | tail -n +2 | sort | uniq)

for i in ${USERS}; do
    COUNTER=0
    MAX_RSS=0
    PID_WITH_MAX_RSS=0

    while read MEM PID; do
        COUNTER=$((${COUNTER}++))
        TOTAL_RSS=$((${TOTAL_RSS} + ${MEM}))

        if [[${MEM} -gt ${MAX_RSS}]]; then
            MAX_RSS=${MEM}
            PID_WITH_MAX_RSS=${PID}
        fi
    done < < (ps -u ${i} -eo rss,pid)

    echo "For user ${i} the number of the running processes is ${COUNTER} and the total RSS is ${TOTAL_RSS}"

    AVERAGE=$((${TOTAL_RSS} / ${COUNTER}))
    
    if [[${MAX_RSS} -gt $((2* ${AVERAGE}))]]; then
            echo "The process with pid ${PID_WITH_MAX_RSS} will be killed"
            kill -s SIGTERM ${PID_WITH_MAX_RSS}
            sleep 2
            kill -9 ${PID_WITH_MAX_RSS} 
    fi
done
