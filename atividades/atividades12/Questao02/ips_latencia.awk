# Não fez o outro?
BEGIN {
	print "Relatório de Latência."
}

{
	printf ("%s ", $1) ; 
	"ping -c 5 " $1 " | tail -n -1 | cut -d ' ' -f4 | cut -d '/' -f 2" | getline lantencia;
	printf ("%s: ms\n", lantencia);
	
}
