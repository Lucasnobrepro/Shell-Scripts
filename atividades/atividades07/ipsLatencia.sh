#!/bin/bash

file="$1"

for line in $(cat $file); do
    echo "$line $(ping -c 5 $line | tail -n -1 | cut -d ' ' -f4 | cut -d '/' -f 2)ms"
done