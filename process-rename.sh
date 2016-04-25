#!/bin/bash

if [[ $# <2 ]];then
	echo "eg:$0 input-name output-name";
	exit;
fi

#process kernel timestamp
cd /home/quyupeng/systemtap/
rename ${1} ${2} ${1}*
#cd -
cd /home/quyupeng/benchmark/memcached/memcached-1.4.17-cooper

#process user timestamp
rename ${1} ${2} ${1}*
