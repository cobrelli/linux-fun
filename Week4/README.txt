Week 4


Longcat

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


Daily maximum

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
	#end_of_script

	Output:
	lost24/monitor//2012.04.25/10:50/hp-temps.txt 54 °C

...in TSV format

	#!/bin/bash
	while read data;do
		echo "$data" | gsed -e 's/\/\+/\//g' | cut -d '/' -f3- | rev | cut -d ' ' -f2- | rev | gsed -e 's/\ /\  /g' -e 's/\//\ /g' | cut -d ' ' -f1,2,4-
	done

	./max-temp.sh lost24/monitor/2011.11.11/ | ./in-tsv-format.sh 

	Output:
	2011.11.11   24

Daily maximums redux

	#!/bin/bash
	dir=$(find lost24/ -type d -maxdepth 2 -mindepth 2)
	for d in $dir;do
		./max-temp.sh $d
	done

	./daily-maximums-redux.sh | ./in-tsv-format.sh

	Output:
	monitor 2012.03.17  38
	monitor 2012.03.18  42
	monitor 2012.03.19  39
	monitor 2012.03.20  41
	monitor 2012.03.21  43

Fast draws with GnuPlot

	graph in max-daily-temps.pdf

Winter is Coming

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

I didn't see that one coming

	graph in daily-temps.pdf

Onwards to getopts and switch

And that's a wrap

	#!/bin/bash
	cmd=""
	opts=""
	unset csv
	unset program
	unset dirname
	print_help() {
  		echo "\
		Usage: `basename $0` [-t] -c | -w -p dir
		Arguments:
        -t        output as tab-separated values
        -c        find the coldest temperature
        -w        find the warmest temperature
        -p dir    search all subdirs of dir"
	}
 
	while getopts ":htcwp:" opt; do
		case $opt in
			t)
				opts="./in-tsv-format-sed.sh"
				;;
			c)
				cmd="./min-temp-sed.sh"
				;;
			w)
				cmd="./max-temp-sed.sh"
				;;
			p)
				cmd="$cmd $OPTARG"
				;;
			\?)
				echo "Invalid option: -$OPTARG" >&2
				print_help
				exit 1
				;;
			esac
	done

	if [ $opts ];then
		$cmd | $opts
	else
		$cmd
	fi



	./find-max-or-min.sh -tcp lost24/monitor/
	2012.02.02 04:15  7

	./find-max-or-min.sh -twp lost24/monitor/
	2012.04.25 10:55  54