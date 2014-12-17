#!/bin/sh
# script for all containers start
# created by koitatu (2014/11/24) 

STOP_CONTINER_ID=`docker ps -a |egrep Exited |awk '{print $NF}' |egrep -v CONTAINER`

for i in ${STOP_CONTINER_ID}
do
        docker start ${i} >/dev/null 2>&1
        if [ $? -eq 0 ];then
		echo "$i start is success."
        else
		echo "$i start is failed."
        fi
	echo "sleep 5"
	sleep 5
done
