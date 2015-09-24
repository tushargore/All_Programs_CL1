/*Assignment name:Implementation of lexical analyzer for finding number of vowels and consonents.
Roll No.56		Div:B
Batch:B3		Date:
*/


/*Declaration Section
*/
%{
   int vowels=0,consonents=0;
   int err=0;
%}
Vowel  [aeiouAEIOU]
Consonent [b-df-hj-np-tv-zB-DF-HJ-NP-TV-Z]
WhiteSpaces [ \t\n]

/*Rule Section
*/
%%
{WhiteSpaces} ;
{Vowel} {vowels++;}
{Consonent} {consonents++;}
. {err++; yyerror(yytext,err);}
%%

/*C-Subroutine Section
*/
int main(int argc,char *argv[])
{
  FILE *fp=fopen(argv[1],"r");
  yyin=fp;
  if(fp==NULL)
  {
    yyerror("File Open Error");
  }
  else
  {
     yylex();
     printf("\n\n\t Total Number of vowels are 		: %d",vowels); 
     printf("\n\n\t Total Number of consonents are 	: %d\n",consonents);
     fclose(fp);
  }
  return 0;
}

int yywrap()
{
  return 1;
}

int yyerror(char msg[],int err)
{
  fprintf(stderr,"\n\tLexical Error%d : Unrecognized tokens %s\n",err,msg);
  return 0;
}

/*
 Output:
bhushan@ubuntu:~$ lex vowel.l
bhushan@ubuntu:~$ gcc lex.yy.c
bhushan@ubuntu:~$ ./a.out file.txt

	Lexical Error1 : Unrecognized tokens #

	Lexical Error2 : Unrecognized tokens <

	Lexical Error3 : Unrecognized tokens .

	Lexical Error4 : Unrecognized tokens >

	Lexical Error5 : Unrecognized tokens (

	Lexical Error6 : Unrecognized tokens )

	Lexical Error7 : Unrecognized tokens {

	Lexical Error8 : Unrecognized tokens (

	Lexical Error9 : Unrecognized tokens )

	Lexical Error10 : Unrecognized tokens ;

	Lexical Error11 : Unrecognized tokens (

	Lexical Error12 : Unrecognized tokens "

	Lexical Error13 : Unrecognized tokens \

	Lexical Error14 : Unrecognized tokens 2

	Lexical Error15 : Unrecognized tokens :

	Lexical Error16 : Unrecognized tokens "

	Lexical Error17 : Unrecognized tokens )

	Lexical Error18 : Unrecognized tokens ;

	Lexical Error19 : Unrecognized tokens (

	Lexical Error20 : Unrecognized tokens "

	Lexical Error21 : Unrecognized tokens %

	Lexical Error22 : Unrecognized tokens %

	Lexical Error23 : Unrecognized tokens "

	Lexical Error24 : Unrecognized tokens ,

	Lexical Error25 : Unrecognized tokens &

	Lexical Error26 : Unrecognized tokens ,

	Lexical Error27 : Unrecognized tokens &

	Lexical Error28 : Unrecognized tokens )

	Lexical Error29 : Unrecognized tokens ;

	Lexical Error30 : Unrecognized tokens 0

	Lexical Error31 : Unrecognized tokens ;

	Lexical Error32 : Unrecognized tokens }


	 Total Number of vowels are 		: 16

	 Total Number of consonents are 	: 40
bhushan@ubuntu:~$ 

*/
