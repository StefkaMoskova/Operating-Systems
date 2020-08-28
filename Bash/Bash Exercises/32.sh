#!/bin/bash

request=$(mktemp)
while read site; do
        http2Counter=$(cat $1 | egrep "$site" | egrep "HTTP/2.0" | wc -l)
        httpNot2Counter=$(cat $1 | egrep "$site" | egrep -v "HTTP/2.0" | wc -l)

        #topUser

        echo "$site HTTP/2.0: $http2Counter $site non-HTTP/2.0: $httpNot2Counter"


        while read usr; do
                statusCodeCounter=0
                while read cur; do
                        status=$(echo $cur | cut -d' ' -f9)

                        if [[ $status -gt 302 ]];then
                                statusCodeCounter=$(($statusCodeCounter + 1))
                        fi

                done< <(cat $1 | egrep "$site" | egrep "$usr")

                echo "$statusCodeCounter $usr" >>  $request

        done< <(cat $1 | egrep "$site" | sort -t' ' -k1 | uniq -c | sort -rn -k1 | head -n 2 | awk '{print $2}')

done< <(cat $1 | sort -t' ' -k2 | cut -d' ' -f2 | uniq -c | sort -rn -k1 | head -n 2 | awk '{print $2}')
cat $request
rm $request
