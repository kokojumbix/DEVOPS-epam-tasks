#!/bin/bash

if [[ $# -eq 1 ]]
then

SUM=$1
BINARY=''
if [[ $1 -lt 256 ]]
then
for (( var = 0; var<8; var++ ))
do
if [[ $(( (2**(7 - $var) ) )) -le $SUM ]]
then
SUM=$(( $SUM - (2**(7 - $var)) ))
BINARY=$BINARY'1'
else
BINARY=$BINARY"0"

fi
done
echo $BINARY

else
echo "Bad argument."

fi


else
	echo "Bad number of arguments."

fi





