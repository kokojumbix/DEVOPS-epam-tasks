#!/bin/bash

SCRIPTNAME="Backupch"

function help {
echo "Help!"
}

function storedata {

if ! [[ -e ~/backupch/ ]]
then
mkdir ~/backupch/
touch ~/backupch/backup_relations
fi

}

function isin {
local IFS='
'
echo $1 | grep "^$2$"
echo $1

}

function update {


local IFS='
'
SYN=( $( cat ~/backupch/backup_relations ) )

IFS=''


for (( i=0; i<${#SYN[@]}; i+=2 ))
do
IFS=''
REALPATH=$( realpath ~/backupch/)"/"
local STORAGE=$REALPATH"storage"$( echo ${SYN[$i]}' '${SYN[(( $i + 1 ))]} | sed 's\/\\g' )



if [[ $( cat "$STORAGE" )  == $( ls -la "${SYN[$i]}" | sed -e 1d | awk '{ if ($9 != "." && $9 != ".." )  print $0 }' )  ]]
then
echo "all nice"

else

echo ":("



IFS='
'
SYNBUF=( $( ls -la "${SYN[$i]}" | sed -e 1d | awk '{ if ($9 != "." && $9 != ".." )  print $0 }' ) )

STBUF=( $( cat "$STORAGE"  ) )



#echo $( printf '%s
#' ${SYNBUF[@]} | grep "t" )
#echo ${SYNBUF[*]}
#echo $( IFS=''; echo ${SYNBUF[*]} | awk '{ print $4 }' )
#echo $( isin ${STBUF[@]} ${SYNBUF[0]})
DESTIN=${SYN[(($i + 1))]}"/storage"$( echo ${SYN[$i]}' '${SYN[(( $i + 1 ))]} | sed 's\/\\g' )
LOGS=$DESTIN"/logs"
DATABUFFER=$(date)



for j in ${!STBUF[@]}
do
if [[  $( printf '%s
' ${SYNBUF[@]} | grep "^${STBUF[$j]}$" ) == '' ]]
then
if [[  $( printf '%s
' ${SYNBUF[@]} | awk '{print $9}' | grep "^$(echo ${STBUF[$j]} | awk '{ print $9 }')$" ) == '' ]]
then
if ! [[ -e "$DESTIN/$DATABUFFER" ]]
then
mkdir "$DESTIN/$DATABUFFER"
fi

echo $(date +%r)" "$(date +%x)" Deleted : "$( echo ${STBUF[$j]} | awk '{ print $9 }' ) | cat >> $LOGS



else
if ! [[ -e "$DESTIN/$DATABUFFER" ]]
then
mkdir "$DESTIN/$DATABUFFER"
fi
echo $(date +%r)" "$(date +%x)" Modified: "$( echo ${STBUF[$j]} | awk '{ print $9 }' ) | cat >> $LOGS
cp  "${SYN[$i]}/$( echo ${SYNBUF[$j]} | awk '{ print $9 }' )" "$DESTIN/$DATABUFFER/"

fi
fi
done


for j in ${!SYNBUF[@]}
do
if [[  $( printf '%s
' ${STBUF[@]} | grep "^${SYNBUF[$j]}$" ) == '' ]]
then

if [[  $( printf '%s
' ${STBUF[@]} | awk '{print $9}' | grep "^$(echo ${SYNBUF[$j]} | awk '{print $9}')$" ) == '' ]]
then
if ! [[ -e "$DESTIN/$DATABUFFER" ]]
then
mkdir "$DESTIN/$DATABUFFER"
fi
echo $(date +%r)" "$(date +%x)" Added   : "$( echo ${SYNBUF[$j]} | awk '{ print $9 }' ) | cat >> $LOGS
cp  "${SYN[$i]}/$( echo ${SYNBUF[$j]} | awk '{ print $9 }' )" "$DESTIN/$DATABUFFER/"
fi
fi
done



fi


done

}



if [[ $# -eq 0 ]]
then
help

elif [[ $# -eq 1 ]]
then

case $1 in
-update) update;;
--update) update;;
*) echo "Unsupported flag."
esac


elif [[ $# -eq 2 ]] && [[ -e $1 ]] && [[ -e $2 ]] && ! [[ -f $2 ]]
then

SYNPATH=$1
STOREPATH=$2 

storedata

RELATIONSYN=$( realpath $SYNPATH )
RELATIONST=$( realpath $STOREPATH )
RELATION=$RELATIONSYN"
"$RELATIONST

RELATIONSTORAGE=$( echo "storage"$RELATIONSYN" "$RELATIONST | sed 's\/\\g'  )


if [[ $( cat ~/backupch/backup_relations | grep "^$RELATION$" ) == '' ]]
	then
	echo $RELATIONSYN | cat >> ~/backupch/backup_relations
	echo $RELATIONST | cat >> ~/backupch/backup_relations
	ls -la $SYNPATH | sed -e 1d | awk '{ if ($9 != "." && $9 != ".." )  print $0 }' | cat > ~/backupch/"$RELATIONSTORAGE"
	mkdir $RELATIONST/"$RELATIONSTORAGE"
	DATEBUF=$(date)
	mkdir $RELATIONST/"$RELATIONSTORAGE"/"$DATEBUF"
	touch $RELATIONST/"$RELATIONSTORAGE"/logs  
	cp -a "$RELATIONSYN/." "$RELATIONST/$RELATIONSTORAGE"/"$DATEBUF"
else
	echo "This backup relation already exists!"

fi


else
echo "Smth went wrong."

fi

