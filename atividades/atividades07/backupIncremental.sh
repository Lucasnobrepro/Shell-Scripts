#!/bin/bash

dir1="$1"
dir2="$2"


for item1 in $(ls dir1); do
    for item2 in $(ls dir2); do
	if [$item1 != $item2]; then
	   cp $dir1/$item2 $dir2
	fi
