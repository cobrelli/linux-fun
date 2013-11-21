#!/bin/bash
if [ $1 -gt 0 ];then
	head -10 shortcat.txt
	for (( i=1; i<=$1; i++ ))
	do
		sed -n 11p shortcat.txt
	done
	tail -8 shortcat.txt | head -7
	name=$(tail -1 shortcat.txt)
	if [ $1 -gt 1 ];then
		echo "${name/Shortcat./Longcat.}"
	else
		echo "$name"
	fi
else
	echo Please check your parameters, should be ./longcat.sh number
	exit 1
fi
