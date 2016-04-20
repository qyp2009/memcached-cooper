#!/bin/bash

if [[ $# < 1 ]];then
	echo "eg:$0 output.txt"
	exit -1;
fi

`dirname $0`/memcached -u root -l 172.18.11.204 -p 11211 -t 1 -c 2048 -v >$1 2>&1
