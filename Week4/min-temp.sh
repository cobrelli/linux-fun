#!/bin/bash
coolest=9999
coolest_file=0
for i in $@
do
	for file in $(find "$i" -name '*hp-temps.txt')
	do
		temp=`cat $file | grep 'PROCESSOR_ZONE' | gsed -e 's/\ \+/,/g' -e 's/\//,/g' -e 's/C/,/g'| cut -d "," -f4`
		if [ "$coolest" -gt "$temp" ]; then
			coolest_file=$file
			coolest=$temp
		fi
	done
done
echo "$coolest_file $coolest °C"
