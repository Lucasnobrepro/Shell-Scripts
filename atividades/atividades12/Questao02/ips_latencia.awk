BEGIN {
	print "\tRelatório de Latência."
}

{
	printf ("%s ", $1) ; 
	"ping -c 5 " $1 " | tail -n -1 | cut -d ' ' -f4 | cut -d '/' -f 2" | getline AVG;
	printf ("%s ms\n", AVG);
	
}