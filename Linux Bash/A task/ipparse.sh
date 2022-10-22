#/bin/bash

ifconfig | grep "inet " | awk '{ if ( $2 !~ "127.***.***.***" ) print $2 " " $4 }'

