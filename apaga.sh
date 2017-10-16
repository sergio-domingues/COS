#!/bin/bash

if [ $# -eq 0 ]
  then 
    echo "usage: $0 <light bulb index>"
    exit 1
fi

{ printf "practica\ncos\n1\n$1\n2\nyes\n\n\033\0334\n"; } | telnet pdujupiter.disca.upv.es