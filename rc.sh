#!/bin/bash
#set -x

function config_ipfs {
	myid=$(ipfs id "--format=<id>")
	echo "configuring $myid ..."
	#ipfs config Addresses
	#optional - change default ports
	ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/5003 #8080
	ipfs config Addresses.API /ip4/0.0.0.0/tcp/5001
	ipfs config --json Swarm.EnableAutoRelay true
	ipfs config --json Experimental.Libp2pStreamMounting true
	ipfs config --json Experimental.FilestoreEnabled true
	ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["https://ipfs.home.m3", "http://127.0.0.1:5001", "https://webui.ipfs.io"]'
	ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "GET", "POST"]'
}

function start_ipfs {
	mkdir -p "${IPFS_PATH}/"

	if [ ! -e "${IPFS_PATH}/config" ]; then
		ipfs init
	fi
	config_ipfs

	ipfs daemon

	printf "ipfs exited"
}

function stop_ipfs {
    ipfs shutdown
}

##
export PATH=${HOME}/.asperitus/ipfs/go-ipfs:$PATH
export IPFS_PATH="${HOME}/.ipfs-m3"

case "$1" in 
    start)
		start_ipfs
		;;
    stop)
		stop_ipfs
		;;
    restart)
		stop_ipfs
		start_ipfs
		;;
    *)
		echo "usage: $0 start|stop|restart" >&2
		exit 1
    	;;
esac