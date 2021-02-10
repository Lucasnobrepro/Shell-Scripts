#Correção: OK
BEGIN { sum = 0 } FNR > 1 && $2 > 5000 { sum = sum + $2 } END { print sum}
