#!/bin/bash

ARR=( $( cat test.txt | awk '{ print $4 }'  | sed 's/://g' ) )
for i in ${ARR[@]}
do
echo -n "IP:" $i"   Name: " 
nslookup $i | awk '{ if ($4 != "find") print $4; else print "NULL" }' | tr '\n' ' '
echo " "
done

