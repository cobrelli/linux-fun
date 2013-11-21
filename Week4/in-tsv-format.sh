#!/bin/bash
while read data;do
	echo "$data" | gsed -e 's/\/\+/\//g' | cut -d '/' -f3- | rev | cut -d ' ' -f2- | rev | gsed -e 's/\ /\  /g' -e 's/\//\ /g' | cut -d ' ' -f1,2,4-
done