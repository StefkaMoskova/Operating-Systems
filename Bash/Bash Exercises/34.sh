#!/bin/bash

if [[ $# -ne 2 ]]; then
	echo "Invalid number of arguments"
	exit 1
fi

if [[ ! -d $1 ]]; then
	echo "${1} is not a directory!"
	exit 2
fi

touch DST
chmod 777 DST
touch DST/images/
chmod 777 DST/images

while read line
do
	cleared=$(echo $line | echo $(tr -s " "|tr " " "\n"|sed "s/(.*)//g"|tr "\n" " "|tr -s " "))
	heading=$(echo $cleared|tr -d ".jpg")
	album=$(echo $line | tr -s " "|grep "(.*)"|tr " " "\n"|grep "(.*)"|tail -n1)
	if [[ $album == ""  ]]i
	then
	       album="misc"	
	fi
	date=$(date -r $1 +"%F")
	hashed=$(sha256sum $line)

	cp "SRC/$line" "DST/images/$hashed.jpg"

	ln --symbolic "DST/images/$hashed.jpg" "DST/by-date/$date/by-album/$album/by-title/$heading.jpg"


done< <(find $1 -name "*.jpg")

##!/bin/bash
#
#function cleaning {
#    echo $(echo $1 | tr -s " ")
#}
#
#function title {
#    title=$(cleaning $1)
#    echo $(echo $title | sed 's/([^()]*)//g'
#}
#
#function album {
#    echo "$1" | sed 's/.*\((.*)\).*/\1/g' | tr -d '()' | sed -E 's/.*.jpg/misc/g'
#}
#
#function data {
#    echo $(find $1 -printf "%TY-%Tm-%Td\n")
#}
#
#
#echo $1
#cleaning $1
#title $1




