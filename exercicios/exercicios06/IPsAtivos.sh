#!/bin/bash

endereco="$1"
echo "Verificacao de enderecos IPs, usando base $endereco."
./auxExec.sh $endereco &
