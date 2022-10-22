#!/bin/bash

if [[ $# -eq 1 ]]
then


BINARY=''
if [[ $1 =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]  
then
IFS='.'
read -r -a ARR <<< "$1"
for i in {0..3}
do
BINARY=$BINARY$( ./byte_decimal_to_binary.sh ${ARR[$i]} )


done
BINARY=$BINARY" "
index=0
for (( i=0; i<32; i++ ))
do
if [[  ${BINARY:$i:1} -eq 1 ]]
then
index=$(( $index + 1 ))
else
break
fi
done

echo $index


else
echo "Bad argument."

fi


else
	echo "Bad number of arguments."

fi





