#!/bin/bash
hottest=0
hottest_file=0
for i in $@
do
	for file in $(find "$i" -name '*hp-temps.txt')
	do
		temp=`cat $file | grep 'PROCESSOR_ZONE' | gsed -e 's/\ \+/,/g' -e 's/\//,/g' -e 's/C/,/g'| cut -d "," -f4`
		if [ "$hottest" -lt "$temp" ]; then
			hottest_file=$file
			hottest=$temp
		fi
	done
done
echo "$hottest_file $hottest °C"
