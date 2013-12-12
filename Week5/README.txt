Week 5

Counting in your head

	#!/bin/bash
	i=0
	sum=0
	for param in $@
	do
		let "sum += param"
		let "i += 1"
	done

	echo "scale=2; $sum / $i" | bc

	output:

	./average.sh 2 3 4
	3.00
	./average.sh 2 3 3
	2.66
	./average.sh 2 3 3
	2.66
	./average.sh 1 6 9
	5.33

Gone in 60 seconds (aka lost24-monitor-recap-megafun)	

	#!/bin/bash
	files=$(find lost24/monitor/ -name hp-temps.txt -exec grep "PROCESSOR_ZONE" {} + | sed -e 's/\s\+/,/g' -e 's/\//\,/g' -e 's/C//g')
	trim=$(echo "$files" | cut -d , -f 7 | cut -d 'C' -f 1)
	files=$(echo "$files" | cut -d , -f 3,4,7)
	hottest=0

	for line in $trim
	do
		if [ "$line" -gt "$hottest" ]
		then
			hottest=$line
		fi
	done

	echo "$hottest"
	echo "$files" | grep ".*,.*,$hottest"

	>>>
	output:
	time ./minmax-megahot.sh 
	54
	2012.04.25,10:55,54
	2012.04.25,10:50,54

	real	0m8.172s
	user	0m6.440s
	sys	0m3.124s

	/////first
	real	0m6.549s
	user	0m5.328s
	sys	0m2.700s

	/////second try
	real	0m7.158s
	user	0m5.708s
	sys	0m2.916s

