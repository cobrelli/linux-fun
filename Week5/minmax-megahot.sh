#!/bin/bash
files=$(find lost24/monitor/ -name hp-temps.txt -exec grep "PROCESSOR_ZONE" {} + | sed -e 's/\s\+/,/g' -e 's/\//\,/g' -e 's/C//g')
trim=$(echo "$files" | cut -d , -f 7 | cut -d 'C' -f 1)
files=$(echo "$files" | cut -d , -f 3,4,7)
hottest=0

for line in $trim
do
	#l=$(echo $line | cut -d 'C' -f3)
	
	if [ "$line" -gt "$hottest" ]
	then
		hottest=$line
	fi
done

echo "$hottest"
echo "$files" | grep "$hottest"
