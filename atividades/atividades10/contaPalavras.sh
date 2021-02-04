#!/bin/bash

file=
one=
read -p "Informe o arquivo:" file

declare -A text

for word in $(cat $file); do
    if [  "${text[$word]}" == "" ]; then
        text["$word"]=1
    else
        text["$word"]=`expr ${text[$word]} + 1`
    fi

done

for i in ${!text[@]}; do
    echo "$i : ${text[$i]}"
done
