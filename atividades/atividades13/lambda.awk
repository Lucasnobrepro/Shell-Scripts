# E o tempo médio?
BEGIN{
    countAll=0
    countOut=0
    timeMSout=0
}

{
    #"cat /home/compartilhado/lambda.log"
    if(NF > 4 && $(NF-3) == "out" )
        countOut= countOut + 1

    if( $2 == "TraceId:")
        countAll= countAll + 1 
}

END{
    printf("1. Quantidade de acessos: %d\n",countAll)
    printf("2. invocações com sucesso: %d\n",countAll - countOut)
    printf("3. Quantidade de Falhas: %d\n",countOut)
}
