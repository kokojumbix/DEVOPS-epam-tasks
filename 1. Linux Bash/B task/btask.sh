#!/bin/bash

function task1 {

local IP=$( cat $1 | awk '{ print $1 }' ) 
declare -A IPARR


for i in $IP
do
IPARR[$i]=$(( ${IPARR[$i]} + 1 ))
done

local MOSTREQ=${!IPARR[@]}
for i in ${!IPARR[@]}
do


if [[ ${IPARR[$i]} -gt  ${IPARR[$MOSTREQ]} ]]
then
MOSTREQ=$i
fi

done
echo $MOSTREQ
}




function task2 {

local IP=$( cat $1 | awk '{ print $7 }' )
declare -A IPARR


for i in $IP
do
IPARR[$i]=$(( ${IPARR[$i]} + 1 ))
done

local MOSTREQ=${!IPARR[@]}
for i in ${!IPARR[@]}
do


if [[ ${IPARR[$i]} -gt  ${IPARR[$MOSTREQ]} ]]
then
MOSTREQ=$i
fi
done

echo $MOSTREQ

}

function task3 {

local IP=$( cat $2 | grep $1 | awk '{ print $1 }')

declare -A IPARR

for i in $IP
do
IPARR[$i]=$(( ${IPARR[$i]} + 1 ))
done

local MOSTREQ=${!IPARR[@]}
for i in ${!IPARR[@]}
do
echo "\\"${IPARR[$i]}" - "$i
done | sort -r

}

function task4 {
cat $1 | awk '{ if ($9 == "302") print "|"$7 }'

}

function task5 {
local INTERVAL=60
local TIME=( $(cat $1 | awk '{ print $4 }' | sed -e 's,/,-,g' -e 's,:, ,' -e "s/\[//") )
for (( i=0; i<${#TIME[@]}; i+=2 ))
do
ARR+=( $( date +%s -d ${TIME[(( $i ))]}" "${TIME[(( $i+1 )) ]} ) )
done

local NOMINAL=0
local NOMINALTIME=0
for i in ${!ARR[@]} 
do

local COUNT=0
for (( j=$i; j<${#ARR[@]}; j++ ))
do

if [[ $(( ${ARR[$j]} - ${ARR[$i]} )) -lt $INTERVAL  ]]
then
COUNT=$(( $COUNT + 1 ))
else
break
fi
done

if [[ $COUNT -gt $NOMINAL ]]
then
NOMINAL=$COUNT
NOMINALTIME=${ARR[i]}
fi

done
date -d @$NOMINALTIME


}


function task6 {
IP=( $(cat $1 | grep "compatible" | grep "[Bot/bot]" | awk '{ print $1 }' ) )
UA=( $(cat $1 | grep "compatible" | grep "[Bot/bot]" | awk '{ print $14 }' ) )

declare -A IPARR
declare -A UAARR
for i in ${IP[@]}
do
IPARR[$i]=$(( ${IPARR[$i]} + 1 ))

done
for i in ${UA[@]}
do
UAARR[$i]=$(( ${UAARR[$i]} + 1 ))
done

echo "ALL BOT UA:"
for i in ${!UAARR[@]}
do
echo $i
done
echo
echo "ALL BOT IP:"
for i in ${!IPARR[@]}
do
echo $i
done
}


if [[ $# -eq 1 && -e $1 ]]
then
echo
echo -n "IP addresses from which were most request: "
task1 $1
echo
echo -n "Most requested page: "
task2 $1
echo "|"
echo "| IP addresses, which requested this page"
echo "|"
task3 $( task2 $1 ) $1
echo
echo
echo "Non-existent pages were cliens referred to:"
task4 $1
echo
echo
echo "Time did site get the most requests:"
task5 $1
echo
echo
task6 $1

else
echo "Wrong arguments."
fi



