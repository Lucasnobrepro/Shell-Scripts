#!/bin/bash

## Criando diretorios de teste
# mkdir dir1
# mkdir dir2

## Criando arquivos de teste
# touch dir1/file1
# touch dir1/file2

dir1="$1"
dir2="$2"
date=$(date -d "$3 $4" +%s)

if [ $# == 4 ]; then
	# Para cada item no diretorio dir1
	for item1 in $(ls dir1); do
		# Pega a data de modificacao
		item_date=$(date -d "$(stat ${dir1}/${item1} | grep -E "Modi" | cut -d' ' -f2- | cut -d'.' -f1)" +%s)
		
		# Compara as datas
		if [ $item_date > $date ]; then
			#Verifica se o o dir2 esta vazio.
			if [ $(ls $dir2| wc -l) == 0 ]; then
				cp $dir1/$item1 $dir2
			else
				# Para cada item no diretorio dir2
				for item2 in $(ls dir2); do
					# Comparo se tem items iguais;
					if [ $item1 != $item2 ]; then
						cp $dir1$item1 $dir2
					fi
				done
			fi
		fi
	done
else
	echo 'Numero de parametros esta incorreto'
fi