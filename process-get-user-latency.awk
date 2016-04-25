#!/usr/bin/awk

BEGIN {
	cmd="";
	n=0;	#index of skb[]
	a=0;	#index of delete_id_cmd[] timestamp
	b=0;	#index of delete_id_data[] timestamp
	c=0;	#index of delete_id_move[] timestamp
	begin=0;
	end=0;
} 

$1=="begin_cmd"{ 
	begin=$3;
	n=0;
	a=0;
	b=0;
	c=0;
} 

$1=="skb_for_cmd" || $1=="skb_for_data"{
	if(n==0 || $3!=skb[n]){
		skb[++n]=$3;
	}
}

$1=="cmd:" {
	cmd=$0;
} 

$1=="delete_id_cmd" {
	delete_id_cmd[++a]=$3;
}
$1=="delete_id_data" {
	delete_id_data[++b]=$3;	
}
$1=="delete_id_move" {
	delete_id_move[++c]=$3;	
}

$1=="end_cmd" {
	end=$3;
	print cmd;
	
	print "timestamp_user: (begin,end) ",begin,end;

	if(a>0){
		printf("overhead_delete_id_cmd: ((begin,end),...) ");
		for(i=1;i<a+1;i++){
			printf("%s ",delete_id_cmd[i]);
		}
		print "";
	}

	if(b>0){
		printf("overhead_delete_id_data: ((begin,end),...) ");
		for(i=1;i<b+1;i++){
			printf("%s ",delete_id_data[i]);
		}
		print "";
	}
	
	if(c>0){
		printf("overhead_delete_id_move: ((begin,end),...) ");
		for(i=1;i<c+1;i++){
			printf("%s ",delete_id_move[i]);
		}
		print "";
	}
	
	printf("skb_id: ");
	for(i=1;i<n+1;i++){
		printf("%s ",skb[i]);
	}
	print "";
	
	print "end_cmd";
}
