#!/bin/bash

if test "adicionar" = "$1"
  then
     echo "$2:$3" >> usuarios.db
elif test "listar" = "$1"
  then
     cat usuarios.db
elif test "remover" = "$1"
    then
    grep -v "$2" usuarios.db >> cache.db
    mv cache.db usuarios.db
fi
