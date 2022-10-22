#!/bin/bash

if [[ $# -eq 1 ]]
then

string=$1
SUM=0
if [[ ${#string} -eq 8 ]]
then
for (( var = 0; var<8; var++ ))
do
SUM=$(( $SUM +  ${string:$var:1} * (2**(7-$var))  ))

done
echo $SUM

else
echo "Bad argument."

fi


else
	echo "Bad number of arguments."

fi





