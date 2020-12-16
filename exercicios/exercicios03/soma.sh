#!/bin/bash
# Correção: OK.
cat compras.txt | cut -f 2 -d " " compras.txt | tr "[:space:]" "+" | sed 's/+$/\n/' | bc
 
