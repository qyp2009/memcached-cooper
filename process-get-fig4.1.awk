#!/bin/awk

$1=="skb_for_cmd" || $1=="skb_for_data" || $1=="cmd:"{ print $0;}
