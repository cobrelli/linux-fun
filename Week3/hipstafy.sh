#!/bin/bash
for file in $1/*; do
	#echo $file
	#inputfile=201007011200.jpg
	inputfile=$file
	echo $inputfile
	#echo $file
	#prefix=${inputfile%.jpg}
	base=$(basename $inputfile)
	prefix=${base%.jpg}
	#echo $prefix
	outputfile=test/$prefix-hipstah.jpg
	echo $outputfile
	convert -sepia-tone 60% +polaroid $inputfile $outputfile
	#convert $inputfile -sepia-tone 60% +polaroid $outputfile
done
