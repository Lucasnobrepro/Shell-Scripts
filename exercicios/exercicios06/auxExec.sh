#!/bin/bash

endereco="$1"
echo "INICIO" >> "$endereco.txt"
for i in $(seq 0 1 255); do
    ping -c 1 -q -w 1 "$endereco.$i" >> logs.txt
    if [ $? == 0 ]; then
        echo "$endereco.$i on" >> "$endereco.txt"    
    fi;
done;

echo "FIM" >> "$endereco.txt"

rm logs.txt