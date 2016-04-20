#!/bin/awk

BEGIN {
	line=""
}

line != $0 {
	print $0
	line = $0
}

