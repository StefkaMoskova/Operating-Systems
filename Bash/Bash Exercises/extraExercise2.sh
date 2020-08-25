# Напишете shell script, който приема 2 параметъра - име на потребител и чиссло. Ако скриптът се изпълнява от root, нека да прекратява
# всички процеси, принадлежащи на зададения потребител, ако идентификаторът на процеса е по-голям или равен на зададеното число.

#!/bin/bash

if [[ $(id -un) -ne 0 ]]; then 
	echo "Must be executed by the root user"
	exit 1
fi

while read PID; do
    if [[ ${PID} -ge $2 ]]: then
        echo "The process with pid ${PID} will be killed"
        kill -9 ${PID}
    fi
done < <(ps -u $1 -eo pid)