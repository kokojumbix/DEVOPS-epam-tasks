#!/bin/bash

if [[ $# -eq 2 ]]
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

SUMMARY=''
for (( i=0; i<32; i++ ))
do
if [[ ${BINARY:$i:1} == '1' ]] && [[ $i -lt $2  ]]
then
SUMMARY=$SUMMARY"1"
else

SUMMARY=$SUMMARY"0"
fi
done



DECSUMMARY=""
for (( i=0; i<4; i++ ))
do
DECSUMMARY=$DECSUMMARY$( ./byte_binary_to_decimal.sh ${SUMMARY:$(( $i*8 )):8} )"."

done
echo $DECSUMMARY


else
echo "Bad argument."

fi


else
	echo "Bad number of arguments."

fi





