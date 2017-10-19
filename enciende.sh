#!/bin/bash

if [ $# -eq 0 ] || [ $1 -gt 8 ] ||  [ $1 -lt 1 ]
  then 
    echo "usage: $0 <light bulb index [1,8]>"
    exit 1
fi

{ printf "practica\ncos\n1\n$1\n1\nyes\n\n\033\0334\n"; } | telnet pdujupiter.disca.upv.es