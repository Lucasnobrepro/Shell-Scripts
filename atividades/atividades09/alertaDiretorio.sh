#!/bin/bash
# Correção: 3,0

time_space="$1"
dir="$2"

vetor=()
add=()
delete=()

nFile="$(ls $dir| wc -l)"

[ -d cache ]
if [ $? != 0 ]; then
    mkdir cache
fi

echo $(ls $dir) > "cache/old.log"

while true 
do 
    mFile="$(ls $dir| wc -l)"
    if [ $mFile -gt $nFile ]; then
        echo $(ls $dir) > "cache/add.log"
        for i in $(cat cache/old.log); do
            vetor+=($i)
        done

        for z in $(cat cache/add.log); do
            if [[ ! " ${vetor[@]} " =~ " $z " ]]; then
                add+=($z)  
            fi
        done
        echo $(date +"%d-%m-%y %T") " Alteração! $nFile->$mFile Adicionados ${add[*]}">> dirSensors.log
        echo $(ls $dir) > "cache/old.log"
        nFile=$mFile
        add=()

    elif [ $mFile -lt $nFile ]; then
        echo $(ls $dir) > "cache/add.log"
        for r in $(cat cache/old.log); do
            [ ! -f $dir/$r ]
            if [ $? == 0 ]; then
                delete+=($r)
            fi
        done
        echo $(date +"%d-%m-%y %T") " Alteração! $nFile->$mFile Removidos  ${delete[*]}">> dirSensors.log
        echo $(ls $dir) > "cache/old.log"
        delete=()
        nFile=$mFile
    fi
    sleep $time_space
done
