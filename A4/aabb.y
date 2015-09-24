/*
Assignment No.4(Group A)
Assignment Name:Parser for sample language using YACC.
Roll No.56		Div:B
Batch:B3		Date:
*/

%{
  #include<stdio.h>
%}
%token M S
%%
L    : Exp '\n' {printf("\n\n\t Given string is valid\n");return 0;}
     ;
Exp  : M Exp S
     |
       
     ;
%%
int main()
{
  printf("\n\n\t Enter input string : ");
  yyparse();
}

int yywrap()
{
  return 1;
}

int yyerror(char err[])
{
  fprintf(stderr,"%s","\n\n\t Invalid String is entered by you!!!\n");
}

/*
 Output:
bhushan@ubuntu:~$ yacc -d aabb.y
bhushan@ubuntu:~$ lex aabb.l
bhushan@ubuntu:~$ gcc lex.yy.c y.tab.c
bhushan@ubuntu:~$ ./a.out


	 Enter input string : aaaaabbbbb


	 Given string is valid
bhushan@ubuntu:~$ ./a.out


	 Enter input string : aaabb


	 Invalid String is entered by you!!!
bhushan@ubuntu:~$ 
*/
