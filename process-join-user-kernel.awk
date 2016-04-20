#!/usr/bin/awk

#awk 'NR==FNR{for(i=2;i<NF+2;i++){a[$1,i-2]=$i};next;} {print $0;} $1=="skb_id:"{ print "timestamp_kernel:","(skb_id,mac,ip,tcp)",$2,a[$2,0],a[$2,1],a[$2,2] }' /home/quyupeng/systemtap/tmp4.txt.out ./tmp4.txt.out 

NR==FNR {
	for(i=2;i<NF+2;i++){
		a[$1,i-2]=$i};next;
} 

{print $0;} 

$1=="skb_id:" {
	for(i=2;i<NF+1;i++){
		#print "timestamp_kernel:","(skb_id,mac,ip,tcp)",$2,a[$2,0],a[$2,1],a[$2,2] 
		print "timestamp_kernel:","(skb_id,mac,ip,tcp)",$i,a[$i,0],a[$i,1],a[$i,2] 
	}
} 
