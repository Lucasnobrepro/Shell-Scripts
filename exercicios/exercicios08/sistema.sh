#!/bin/bash

trap "echo \"TCHAU Obrigado por usar o Progama!!!\"; exit;" 2
opcao=
key=

menu() {
    echo '1: Tempo ligado (uptime)'
    echo '2: Últimas Mensagens do Kernel (dmesg | tail -n 10)'
    echo '3: Memória Virtual (vmstat 1 10)'
    echo '4: Uso da CPU por núcleo (mpstat -P ALL 1 5)'
    echo '5: Uso da CPsU por processos (pidstat 1 5)'
    echo '6: Uso da Memória Física (free -m)'
    read -p "->" opcao
}

timeOn() {
    uptime
}

lastMessage() {
    dmesg | tail -n 10
}

memoryVitual() {
    vmstat 1 10
}

cpuCore() {
    mpstat -P ALL 1 5
}

cpuProcess () {
    pidstat 1 5
}

memoryPhy() {
    free -m
}

readSpace() {
    read -s -n 1 key

    if [[ $key == "" ]]; then
        clear
    fi
}

while true; do

    menu

    if [ $opcao == '1' ]; then
        timeOn
        readSpace
    elif [ $opcao == '2' ]; then
        lastMessage
        readSpace
    elif [ $opcao == '3' ]; then
        memoryVitual
        readSpace
    elif [ $opcao == '4' ]; then
        cpuCore
        readSpace
    elif [ $opcao == '5' ]; then
        cpuProcess
        readSpace
    elif [ $opcao == '6' ]; then
        memoryPhy
        readSpace
    fi
done;