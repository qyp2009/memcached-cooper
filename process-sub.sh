#!/bin/bash
#set -x

for arg in $@
do
	echo $arg
	echo -n $((arg))" "
done
