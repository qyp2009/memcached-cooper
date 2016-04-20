#!/usr/bin/awk

BEGIN {
	cmd="";
	n=0;
	begin_raw=0;
	begin=0;
	end=0;
} 

$1=="begin_cmd_raw"{ 
	begin_raw=$3;
	n=0;
} 

$1=="begin_cmd" {
	begin=$3;
} 
$1=="skb_for_cmd" || $1=="skb_for_data"{
	if(n==0 || $3!=skb[n]){
		skb[++n]=$3;
	}
}

$1=="cmd_begin:" {
	cmd=$0;
} 

$1=="end_cmd" {
	end=$3;
	print cmd;
	print "timestamp_user: (begin_raw,begin,end) ",begin_raw,begin,end;
	printf("skb_id: ");
	for(i=1;i<n+1;i++){
		printf("%s ",skb[i]);
	}
	print "";
	print "end_cmd";
}
