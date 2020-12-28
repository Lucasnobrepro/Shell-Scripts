#!/bin/bash
# Correção: 1,0
sed -Ei 's:/bin/python:/usr/bin/python3:' /home/compartilhado/atividade04.py
sed -Ei 's:nota1:NOTA1: ; s:nota2:NOTA2: ; s:notaFinal:NOTAFINAL:' /home/compartilhado/atividade04.py
sed -Ei '3a \import time' /home/compartilhado/atividade04.py
sed -Ei '$a \   time.ctime() ' /home/compartilhado/atividade04.py
