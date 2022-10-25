#!/bin/bash

function ipname {
local IFS="
"
IIFA=$(cat test.txt | awk '{ print $4 }'  | sed 's/://g')

for i in ${IIFA[@]}
do
echo -n "IP:" $i"   Name: " 
nslookup $i | awk '{ if ($4 != "find") print $4; else print "NULL" }' | tr '\n' ' '
echo " "
done
}


function byte_binary_to_decimal {
if [[ $# -eq 1 ]]
then
local string=$1
local SUM=0
if [[ ${#string} -eq 8 ]]
then
for (( var = 0; var<8; var++ ))
do
local SUM=$(( $SUM +  ${string:$var:1} * (2**(7-$var))  ))

done
echo $SUM

else
echo "Bad argument."
fi
else
        echo "Bad number of arguments."
fi


}


function byte_decimal_to_binary {
if [[ $# -eq 1 ]]
then

local SUM=$1
local BINARY=''
if [[ $1 -lt 256 ]]
then
for (( var = 0; var<8; var++ ))
do
if [[ $(( (2**(7 - $var) ) )) -le $SUM ]]
then
local SUM=$(( $SUM - (2**(7 - $var)) ))
local BINARY=$BINARY'1'
else
local BINARY=$BINARY"0"

fi
done
echo $BINARY

else
echo "Bad argument."

fi


else
        echo "Bad number of arguments."

fi


}


function webaddress {

if [[ $# -eq 2 ]]
then


BINARY=''
if [[ $1 =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]
then
local IFS='.'
read -r -a ARR <<< "$1"
for i in {0..3}
do
BINARY=$BINARY$( byte_decimal_to_binary ${ARR[$i]} )


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



local DECSUMMARY=""
for (( i=0; i<4; i++ ))
do
local DECSUMMARY=$DECSUMMARY$( byte_binary_to_decimal ${SUMMARY:$(( $i*8 )):8} )"."

done
echo $DECSUMMARY

else
echo "Bad argument."
fi


else
        echo "Bad number of arguments."
fi


}


function help {
echo "Use" 
echo "	--all		scan every host in your subnet (by interfaces)."
echo "	--target	scan open TCP ports."
echo "Note: to use --target flag nmap must be installed."
}

function getip {
ifconfig | grep "inet " | awk '{ if ( $2 !~ "127.***.***.***" ) print $2 " " $4 }'
}

function CIDRmask {
if [[ $# -eq 1 ]]
then

local BINARY=''
if [[ $1 =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]
then
OIFS="$IFS"
IFS='.'
read -r -a ARR <<< "$1"
IFS="$OIFS"
for i in {0..3}
do
local BINARY=$BINARY$( byte_decimal_to_binary ${ARR[$i]} )

done
local BINARY=$BINARY" "
local index=0
for (( i=0; i<32; i++ ))
do
if [[  ${BINARY:$i:1} -eq 1 ]]
then
local index=$(( $index + 1 ))
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
}


if [[ $# -eq 0 ]]
    then 
	help

elif [[ $# -eq 1 ]]
function all {

local ALLIPS=$( getip )
local ARRAY=$( echo $ALLIPS )
IFS=' '
read -r -a ARR <<< "$ARRAY"
echo "Addresses for analysis"
for (( i=0; i< $((  ${#ARR[@]} / 2  )); i++ ))
do
echo $(( $i+1 ))") IP: " ${ARR[$(( $i * 2 ))]} " | Netmask: " ${ARR[$(( $i * 2 + 1 ))]}  
done
if [[ ${#ARR[@]} -ne 1  ]]
then
SN=0
echo "Select the address by entering the serial number: "
read SN
re='^[0-9]+$'

if ! [[ $SN =~ $re ]]
	then
	echo "Error: Not a number."
	exit 1
fi

if [[ $SN -lt 1 || $(( ${#ARR[@]} / 2 )) -lt $SN ]]
	then
	echo "Error: No such address exists."
	exit 1
fi
CHOSENIP=${ARR[$(( ($SN - 1) * 2 ))]}
CHOSENMASK=${ARR[$(( ( ($SN - 1) * 2) + 1 ))]}

else
CHOSENIP=${ARR[0]}
CHOSENMASK=${ARR[0]}
fi


MASKCIDR=$( CIDRmask $CHOSENMASK )
for (( i=1; i< (( ( 2 ** (32-$MASKCIDR) ) - 2 )); i++ ))
do
PINGBUFFER=$( webaddress $CHOSENIP $MASKCIDR )
PINGADDRESS=( $( echo $PINGBUFFER | awk -F "." '{ print $1,$2,$3,$4 }' ) )
PINGADDRESS[3]=$(( ${PINGADDRESS[3]} + ($i%255) ))
PINGADDRESS[2]=$(( ${PINGADDRESS[2]} + ($i/255) ))"."
PINGADDRESS[1]=$(( ${PINGADDRESS[1]} + ($i/255/255) ))"."
PINGADDRESS[0]=$(( ${PINGADDRESS[0]} + ($i/255/255/255) ))"."

ping ${PINGADDRESS[0]}${PINGADDRESS[1]}${PINGADDRESS[2]}${PINGADDRESS[3]} -c 1 | grep "from" | cat >> test.txt & 


done

sleep 3
echo
echo
echo "Result:"
ipname

#rm test.txt


}
function target {
echo -n "Input IP-address to scan open ports [192.168.31.1]: "
TCPIPSCAN=''
read TCPIPSCAN
echo $TCPIPSCAN
if [[ $TCPIPSCAN =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]
then
echo "Scanning $TCPIPSCAN open TCP ports..."
nmap -sT $TCPIPSCAN
elif [[ $TCPIPSCAN == '' ]]
then
echo "Scanning 192.168.31.1 open TCP ports..."
nmap -sT 192.168.31.1
else
echo "Bad input ( IP-format = xxx.xxx.xxx.xxx )"
fi

}

then
case $1 in	
--all)  
	all;;
-all)
	all;;
--target)
	target;;
-target)
	target;;	

*)
	help;;
esac
fi



