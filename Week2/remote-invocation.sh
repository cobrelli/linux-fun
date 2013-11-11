#! /bin/bash

hostname=$1
command=$2

#echo $hostname $command
ssh $hostname $command
