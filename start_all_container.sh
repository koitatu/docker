#!/bin/sh

STOP_CONTINER_ID=`docker ps -a |egrep Exited |awk '{print $NF}' |egrep -v CONTAINER`

for i in ${STOP_CONTINER_ID}
do
        docker start ${i} >/dev/null 2>&1
        if [ $? -eq 0 ];then
		echo "$i start is success."
        else
		echo "$i start is faile."
        fi
	echo "sleep 5"
	sleep 5
done
