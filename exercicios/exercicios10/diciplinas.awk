#!/usr/bin/awk
BEGIN{
	print "Relatorio diciplina:"		
}
{
	nota[0] = $NF
	nota[1] = $NF-1
	nota[2] = $NF-2
	nota[3] = $NG-3
	for(j=0; j<3; j++)
		print $NF-j
		print nota[j+1]
		if($NF-j < nota[j+1]){
			menor =  nota[j]
			id=j
		printf "id: %d.\n", id
		}
	media = (nota[0] + nota[1] + nota[2] + nota[3]) /3
	name=""
	for(i=0; i < NF-3;i++)
		name=name $i " "

	if (media >= 7){
		aprovados[name]=media
		print aprovados[name]
	}
}
END{
	print "Fim"
}
