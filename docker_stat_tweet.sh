#!/bin/sh

### Set Env ###
DATE=`/bin/date +'%Y-%m-%d%-%H%M'`
source ~/.bti
source ~/.bashrc
DIR_NAME=`/bin/readlink -f $0 |xargs dirname`
HOST_LIST="${DIR_NAME}/docker_host_list"
CHK_PORT_LIST="${DIR_NAME}/docker_check_port_list"
RESULT_TMP="/tmp/docker_container_check_result_${DATE}"


### Start Main Routine ###
while read HOST
do
  DATE2=`/bin/date +'%c'`
  docker ps |egrep -w "${HOST}" >> ${RESULT_TMP} 2>&1
  if [ $? -ne 0 ] ;then
    echo "@koitatu_docker dockerコンテナ監視用botちゃん: ${HOST}が落ちてるっぽいなう。(${DATE2})" |/usr/bin/bti 
    echo "@koitatu_docker dockerコンテナ監視用botちゃん: ${HOST}が落ちてるっぽいなう。(${DATE2})" |/usr/bin/bti -action direct --user koitatu_docker
  else
    while read CHK_LIST
    do
      DATE3=`/bin/date +'%c'`
      CHK_PORT=`echo ${CHK_LIST} |awk '{print $1}'`
      CHK_SERVICE=`echo "${CHK_LIST}" |awk '{print $2}'` 
      docker inspect ${HOST} |grep -i IPAddress |awk '{print $2}' |sed -e 's|,||g' |xargs nmap |egrep "^${CHK_PORT}\/" >> ${RESULT_TMP} 2>&1
      if [ $? -ne 0 ] ;then
        echo "@koitatu_docker dockerコンテナ監視用botちゃん: ${HOST}の${CHK_SERVICE}が落ちてるっぽいなう。(${DATE3})" |/usr/bin/bti --action direct --user koitatu_docker 
        echo "@koitatu_docker dockerコンテナ監視用botちゃん: ${HOST}の${CHK_SERVICE}が落ちてるっぽいなう。(${DATE3})" |/usr/bin/bti --action direct --user koitatu_docker 
      fi
    done < ${CHK_PORT_LIST}
  fi
done < ${HOST_LIST}

### End Main Routine ###
