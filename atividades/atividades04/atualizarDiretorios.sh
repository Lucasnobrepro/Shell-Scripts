#!/bin/bash
# Correção: 1,0
sed -E 's:/home/alunos/:/srv/students/:' /etc/passwd > passwd.new

