#!/bin/bash

file=$1
one=
# read -p "Informe o arquivo:" file

declare -A text

for word in $(cat $file); do
    # echo $($text[$word])
    if [  "${text[$word]}" == "" ]; then
        text["$word"]=1
    else
        text["$word"]=`expr ${text[$word]} + 1`
    fi

done

for i in ${!text[@]}; do
    echo "$i : ${text[$i]}"
done