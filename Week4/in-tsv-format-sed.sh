#!/bin/bash
while read data;do
	echo "$data" | sed -e 's/\/\+/\//g' | cut -d '/' -f3- | rev | cut -d ' ' -f2- | rev | sed -e 's/\ /\  /g' -e 's/\//\ /g' | cut -d ' ' -f1,2,4-
done