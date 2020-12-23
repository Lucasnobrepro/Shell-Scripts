#!/bin/bash

if test "adicionar" = "$1"
  then
     echo "$2:$3" >> usuarios.db
elif test "listar" = "$1"
  then
     cat usuarios.db
fi
