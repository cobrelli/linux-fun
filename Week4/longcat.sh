#!/bin/bash
if [ $1 -gt 0 ];then
	cat head.txt
	echo
	for (( i=1; i<=$1; i++ ))
	do
		echo '       |       |'
	done

	cat tail.txt
	if [ $1 -gt 1 ];then
		echo '                Longcat.'
	else
		echo '                Shortcat.'
	fi
else
	echo Please check your parameters, should be ./longcat.sh number
	exit 1
fi
