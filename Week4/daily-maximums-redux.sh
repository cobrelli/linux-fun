#!/bin/bash
dir=$(find lost24/ -type d -maxdepth 2 -mindepth 2)
for d in $dir;do
	./max-temp.sh $d
done