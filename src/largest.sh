#!/bin/sh

num1=$1
num2=$2
num3=$3

if(("$#" != 3)); then
   echo "Illegal number of arguments"
   exit 1
fi

if [ "$num1" -gt "$num2" ] && [ "$num1" -gt "$num3" ]; then
   echo "$num1"
elif [ "$num2" -gt "$num1" ] && [ "$num2" -gt "$num3" ]; then
   echo "$num2"
else
   echo "$num3"
fi
