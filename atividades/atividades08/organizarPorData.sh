#!/bin/bash

dir1="$1"
dir2="$2"

for i in $(ls ./$dir1); do
    date="$(stat $dir1/$i | grep -E "Modi" | cut -d' ' -f2 | cut -d'-' -f1-)"
    ano=$(echo $date | cut -d'-' -f1)
    mes=$(echo $date | cut -d'-' -f2)
    dia=$(echo $date | cut -d'-' -f3)

    [ -d $dir2/$ano ]
    if [  $? != 0 ]; then
        mkdir $dir2/$ano
    fi

    [ -d $dir2/$ano/$mes ]
    if [ $? != 0 ]; then
        mkdir $dir2/$ano/$mes
    fi

    [ -d $ano/$mes/$dia ]
    if [ $? != 0 ]; then
        mkdir $dir2/$ano/$mes/$dia
        cp $dir1/$i $dir2/$ano/$mes/$dia/
    fi

    
    
done