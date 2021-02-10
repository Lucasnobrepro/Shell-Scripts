#Correção: OK
BEGIN {cont=0} $NF ~ /@gmail.com$/ { cont= cont + 1} END {printf "Existem %d\n", cont}
