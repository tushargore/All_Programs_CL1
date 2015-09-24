/*
Assignment No.4(Group A)
Assignment name:Parser for sample language using YACC
Roll No.56		Div:B
Batch:B3		Date:
*/

%{
  #include<stdio.h>
%}
%token M S
%%
L   : Exp S '\n' {printf("\n\n\t Valid string\n");return 0;}
    ;
Exp : M Exp
    |
      M
    ;
%%
int main()
{
  printf("\n\n\t Enter the string : ");
  yyparse();
}

int yywrap()
{
  return 1;
}

int yyerror(char err[])
{
  fprintf(stderr,"%s","\n\n\t Invalid Input String\n");
}


/*
*****************OUTPUT****************************
bhushan@ubuntu:~$ yacc -d aab.y
bhushan@ubuntu:~$ lex aab.l
bhushan@ubuntu:~$ gcc lex.yy.c y.tab.c
bhushan@ubuntu:~$ ./a.out


	 Enter the string : aaaaabb


	 Invalid Input String
bhushan@ubuntu:~$ ./a.out


	 Enter the string : aaaaaaab


	 Valid string
bhushan@ubuntu:~$ 

*/
