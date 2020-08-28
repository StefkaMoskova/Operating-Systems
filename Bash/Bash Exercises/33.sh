#!/bin/bash

#   Command to make .tar file: 
#       tar -cvf name.tar /path/to/directory 
#   Command to .tar.xz: 
#       tar -cJf linux-3.12.6.tar.xz linux-3.12.6/

#!/bin/bash

function mkTar {
	tar -cJf temp.tar.xz $1
	mv ./temp.tar.xz ./$(checkSum ./temp.tar.xz).tar.xz
	echo "$(checkSum ./temp.tar.xz).tar.xz"
}

firstName=$(basename $1)
versionPack=$(cat ${1}/version)
checkSum=$(sha256sum $1 | awk '{print $1}')
myTar=$(mkTar $1)

while read version hash; do

	if [[  $version  == $(echo "$firstname-$versionPack") ]]; then
		mv ./$myTar $2/packages/$hash.tar.xz
	else
		echo "$firstname-$versionPack $checkSum" >> $2/db
		mv ./$myTar $2/packages
	fi

done< <(cat $2/db)


