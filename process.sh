#!/bin/bash

if [[ $# <1 ]];then
	echo "eg:$0 input";
	exit;
fi

#process kernel timestamp
cd /home/quyupeng/systemtap/
./process-skb-id-timestamp.sh ${1}.txt > ${1}.txt.out
    if [[ $? != 0 ]]; then
	    exit;
	else
		echo "process kernel timestamp success";
	fi 
#cd -
cd /home/quyupeng/benchmark/memcached/memcached-1.4.17-cooper

#process user timestamp
cp cooper-thread-0.txt ${1}.txt
awk -f ./process-get-user-latency.awk ${1}.txt > ${1}.txt.out
awk -f ./process-join-user-kernel.awk /home/quyupeng/systemtap/${1}.txt.out ./${1}.txt.out > ${1}.txt.out.join
./process-get-latency.sh ${1}.txt.out.join >${1}.result
    if [[ $? != 0 ]]; then
	    exit;
	else
		echo "process kernel timestamp success";
	fi 




##process kernel timestamp
#cd /home/quyupeng/systemtap/
#./process-skb-id-timestamp.sh tmp4.txt > tmp4.txt.out
#    if [[ $? != 0 ]]; then
#	    exit;
#	else
#		echo "process kernel timestamp success";
#	fi 
##cd -
#cd /home/quyupeng/benchmark/memcached/memcached-1.4.17-cooper
#
##process user timestamp
#awk -f process-get-user-latency.awk tmp4.txt > tmp4.txt.out
#    if [[ $? != 0 ]]; then
#	    exit;
#	else
#		echo "process user timestamp success";
#	fi 
#awk -f ./process-join-user-kernel.awk /home/quyupeng/systemtap/tmp4.txt.out ./tmp4.txt.out > tmp4.txt.out.join
#./process-get-latency.sh tmp4.txt.out.join >tmp4.result
#
