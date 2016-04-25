#!/bin/bash
set +x

if [[ $# < 1 ]] || [ ! -f "$1" ];then
	echo "eg:$0 input.txt";
	exit -1;
fi

begin="";
end="";
overhead_cmd=0;
overhead_data=0;
overhead_move=0;

prev="";

while read line
do
	arr=($line)
	if [[ "${arr[0]}" == "cmd:" ]];then
		#printf "%s" "$line";
		if [[ "${arr[1]}" == "set" ]];then
			printf "set_%s\t" ${arr[5]};
		elif [[ "${arr[1]}" == "get" ]];then
			printf "get\t";
		fi		
	elif [[ "${arr[0]}" == "timestamp_user:" ]];then 
		begin=${arr[2]};
		end=${arr[3]};
		prev="user";
		overhead_cmd=0;
		overhead_data=0;
		overhead_move=0;
	elif [[ "${arr[0]}" == "timestamp_kernel:" ]];then
		if [[ "$prev" = "kernel" ]];then
			printf "\n\t";
		fi
		printf "%s\t%s\t%s\t%s" ${arr[2]} $(((${arr[4]}-${arr[2]})/1000)) $(((${arr[5]}-${arr[4]})/1000)) $((($begin-${arr[5]})/1000))
		prev="kernel";
	elif [[ "${arr[0]}" == "overhead_delete_id_cmd:" ]];then
		#printf "\n%d\n" ${#arr[@]}; 
		for ((i=2;i<${#arr[@]}-1;i+=2))
		do
			overhead_cmd=$(($overhead_cmd+$((${arr[i+1]}-${arr[i]}))));
		done
	elif [[ "${arr[0]}" == "overhead_delete_id_data:" ]];then
		#printf "\n%d\n" ${#arr[@]}; 
		for ((i=2;i<${#arr[@]}-1;i+=2))
		do
			overhead_data=$(($overhead_data+$((${arr[i+1]}-${arr[i]}))));
		done
	elif [[ "${arr[0]}" == "overhead_delete_id_move:" ]];then
		#printf "\n%d\n" ${#arr[@]}; 
		for ((i=2;i<${#arr[@]}-1;i+=2))
		do
			overhead_move=$(($overhead_move+$((${arr[i+1]}-${arr[i]}))));
		done
	elif [[ "${arr[0]}" == "end_cmd" ]];then
		printf "\t%s\toverhead\t%s\t%s\t%s\n" $((($end-$begin)/1000)) $(($overhead_cmd/1000)) $(($overhead_data/1000)) $(($overhead_move/1000))
	fi

done < $1
