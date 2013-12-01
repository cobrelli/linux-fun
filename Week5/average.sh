#!/bin/bash
i=0
sum=0
for param in $@
do
	let "sum += param"
	let "i += 1"
done

echo "scale=2; $sum / $i" | bc