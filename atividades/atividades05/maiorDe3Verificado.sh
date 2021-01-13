#!/bin/bash

num1="$1"
num2="$2"
num3="$3"
regex='^[0-9]+$'

for i in $num1 $num2 $num3
do
    if ! [[ ${i} =~ $regex ]]
    then
        echo "O caractere ${i} não é número."
        exit 1
    elif [ ${i} -gt ${num1} ]
    then
        num1=${i}
    fi;
done

echo $num1