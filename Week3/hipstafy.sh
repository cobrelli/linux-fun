#!/bin/bash
for file in $1/*; do
	inputfile=$file
	base=$(basename $inputfile)
	prefix=${base%.jpg}
	outputfile=test/$prefix-hipstah.jpg
	convert -sepia-tone 60% +polaroid $inputfile $outputfile
done
