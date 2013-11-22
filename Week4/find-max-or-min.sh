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
