#!/bin/bash

function help {
echo "Use" 
echo "	--all		scan every host in your subnet (by interfaces)."
echo "	--target	scan open TCP ports."
echo "Note: to use --target flag nmap must be installed."
}
function getip {
	./ipparse.sh
}


if [[ $# -eq 0 ]]
    then 
	help

elif [[ $# -eq 1 ]]
function all {
ALLIPS=$( getip )
ARRAY=$( echo $ALLIPS )
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


MASKCIDR=$( ./CIDRmask.sh $CHOSENMASK )
for (( i=1; i< (( ( 2 ** (32-$MASKCIDR) ) - 2 )); i++ ))
do
PINGBUFFER=$( ./webaddress.sh $CHOSENIP $MASKCIDR )
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
./ipname.sh

rm test.txt


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



