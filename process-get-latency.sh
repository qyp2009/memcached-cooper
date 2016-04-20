#!/bin/bash
set +x

if [[ $# < 1 ]] || [ ! -f "$1" ];then
	echo "eg:$0 input.txt";
	exit -1;
fi

begin_raw="";
begin="";
end="";

prev="";

while read line
do
	arr=($line)
	if [[ "${arr[0]}" == "cmd_begin:" ]];then
		#printf "%s" "$line";
		if [[ "${arr[1]}" == "set" ]];then
			printf "set_%s\t" ${arr[5]};
		elif [[ "${arr[1]}" == "get" ]];then
			printf "get\t";
		fi		
	elif [[ "${arr[0]}" == "timestamp_user:" ]];then 
		begin_raw=${arr[2]};
		begin=${arr[3]};
		end=${arr[4]};
		prev="user";
	elif [[ "${arr[0]}" == "timestamp_kernel:" ]];then
		if [[ "$prev" = "kernel" ]];then
			printf "\n\t";
		fi
		printf "%s\t%s\t%s\t%s" ${arr[2]} $(((${arr[4]}-${arr[2]})/1000)) $(((${arr[5]}-${arr[4]})/1000)) $((($begin_raw-${arr[5]})/1000))
		prev="kernel";
	elif [[ "${arr[0]}" == "end_cmd" ]];then
		printf "\t%s\n" $((($end-$begin_raw)/1000))
	fi

done < $1
