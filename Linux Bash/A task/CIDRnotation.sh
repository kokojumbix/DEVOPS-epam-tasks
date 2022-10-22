#!/bin/bash

ipcalc -p 1.1.1.1 $1 | sed 's/PREFIX=//g'



