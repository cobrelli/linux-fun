#!/bin/bash
hottest=0
hottest_file=0
for file in $(find lost24/ -name *hp-temps.txt -path */2011.11.*/*)
do
	temp=`cat $file | grep 'PROCESSOR_ZONE' | gsed -e 's/\ \+/,/g' -e 's/\//,/g' | cut -c19-20`
	if [ "$hottest" -lt "$temp" ]; then
		hottest_file=$file
		hottest=$temp
	fi
done;

echo "Hottest temp"
echo "$hottest"
echo "Found in"
echo "$hottest_file"