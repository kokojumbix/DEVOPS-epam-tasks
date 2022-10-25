#!/bin/bash

function help {
echo "Help!"
}


if [[ $# -eq 0 ]]
then
help

elif [[ $# -eq 1 ]]
then
echo $#


elif [[ $# -eq 2 ]] && [[ -e $1 ]] && [[ -e $2 ]] && ! [[ -f $2 ]]
then
ls



else
echo "Smth went wrong. Maybe arguments :3"

fi

