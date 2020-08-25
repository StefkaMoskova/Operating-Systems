# Напишете shell script, който ако се изпълнява от root, да изведе статистика кои са 3-те най-използвани командни интерпретатори 
# от потребителите в системата и колко потребители ги използват.

#!/bin/bash

if [[ $(id -un) -ne 0 ]]; then 
	echo "Must be executed by the root user"
	exit 1
fi

cut -d: -f7 /etc/passwd | sort | uniq -c | sort -rn | head -n3
