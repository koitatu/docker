#!/bin/sh
# script for all containers stop
# created by koitatu (2014/11/24)

UP_CONTINER_ID=`docker ps |egrep Up |awk '{print $NF}' |egrep -v CONTAINER`

for i in ${UP_CONTINER_ID}
do
	docker stop ${i} >/dev/null 2>&1
	if [ $? -eq 0 ];then
		echo "$i stop is success."
	else
		echo "$i stop is faile."
	fi
	echo "sleep 5"
	sleep 5
done
