#!/bin/bash

TEMP=$(mktemp)
egrep '^(0?|-?[1-9]+)$' >> TEMP 

while read NUMBERS; do
    ABS=$(echo "${NUMBERS}" | grep -o '[0-9]+')
    MAX_ABS=$(cat TEMP | sort -n | uniq | tail -n 1 | grep -o '[0-9]+')

	if [[ ${ABS} -eq MAX_ABS ]]; then	
		echo "${NUMBERS}"
	fi

done < <(cat TEMP| sort -n |uniq )
rm TEMP

# #!/bin/bash

# TEMP=$(mktemp)
# RESULT=$(mktemp)
# MAX_SUM=0
# egrep '^(0?|-?[1-9]+)$' >> TEMP

# while read NUMBERS; do
# 	if [[ "$(echo "${NUMBERS}" | egrep -o '[0-9]+' | egrep -o . | wc -l )" -ge 2 ]];then 
	
# 		if [ "${MAX_SUM}" -le "$(echo "${NUMBERS}" | egrep -o '[0-9]+' | sed 's/./\0\+/g' | sed '$s/+$//' | bc)" ];then 
# 		 MAX_SUM="$(echo "${NUMBERS}" | egrep -o '[0-9]+' | sed 's/./\0\+/g' | sed '$s/+$//' | bc)" 
# 		fi
# 		echo "${MAX_SUM} ${NUMBERS}" > RESULT
# 	fi	
# done < <(cat TEMP| sort -n | uniq)

# cat RESULT | sort -n | tail -n 1 | cut -d ' ' -f2
# rm TEMP
# rm RESULT