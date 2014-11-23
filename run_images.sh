#!/bin/sh
# script for docker run command
# created by koitatu (2014/11/24)
#

###Set env ###
CONTAINER_NAME=$1
CONTAINER_HOSTNME=$2
PORT_MAPPING=$3
RUN_IMAGE_NMAE=$4
#/Set env ###

### Set function ###
run_not_port_mapping(){
docker run --name ${CONTAINER_NAME} -h ${CONTAINER_HOSTNME} -dit ${RUN_IMAGE_NMAE} /bin/bash -c 'sh /root/service.sh'
}

echo_run_not_port_mapping(){
echo "run_not_port_mapping?(y/n)"
echo "exec: [docker run --name ${CONTAINER_NAME} -h ${CONTAINER_HOSTNME} -dit ${RUN_IMAGE_NMAE} /bin/bash -c 'sh /root/service.sh']"
}

run_port_mapping(){
docker run --name ${CONTAINER_NAME} -h ${CONTAINER_HOSTNME} -p ${PORT_MAPPING} -dit ${RUN_IMAGE_NMAE} bin/bash -c 'sh /root/service.sh'
}

echo_run_port_mapping(){
echo "run_port_mapping?(y/n)"
echo "exec: [docker run --name ${CONTAINER_NAME} -h ${CONTAINER_HOSTNME} -p ${PORT_MAPPING} -dit ${RUN_IMAGE_NMAE} bin/bash -c 'sh /root/service.sh']"
}
### /Set function ###

### Start routine ###
if [ $# -eq 3 ];then
	echo_run_not_port_mapping
	read STDIN
	case ${STDIN} in 
		y)
		 run_not_port_mapping
		 ;;
		n)
		 echo "Exec is cancelled."
		 exit ;
		 ;;
		*)
		 echo "Invalid args. Exec is cancelled"
		 exit ;
		 ;;
	esac
elif [ $# -eq 4 ];then
	echo_run_port_mapping
	read STDIN
	case ${STDIN} in 
		y)
		 run_port_mapping
		 ;;
		n)
		 echo "Exec is cancelled."
		 exit ;
		 ;;
		*)
		 echo "Invalid args. Exec is cancelled"
		 exit ;
		 ;;
	esac
else
	echo "Invalid args. Check args num."
	echo "$0 [CONTAINER_NAME] [CONTAINER_HOSTNME] [RUN_IMAGE_NMAE] [PORT_MAPPING(optional)]"
	exit 1;
fi	
### /Start routine ###
