/*
 Assignment No: 4(A)
 Assignemnt Name: Parser for sample language using YACC for Calculator.
*/

%{
   #include<stdio.h>
   #include<math.h>
%}
%union
{
 double dval;
}
%token <dval> NUMBER
%type <dval> E
%left '-' '+'
%left '*' '/'
%left '%'
%right '^'
%nonassoc UMINUS
%%
start : E '\n' {printf("\n\n\t Answer = %f \n",$1);return 0;}
      ;
E :NUMBER {$$=$1;}
  |E'+'E {$$=$1+$3;}
  |E'-'E {$$=$1-$3;}
  |E'*'E {$$=$1*$3;}
  |E'/'E {if($3==0){yyerror("Error:Divide by Zero");return 0;}else {$$=$1/$3;}}
  |E'^'E {$$=pow($1,$3);}
  |'-'E {$$=-$2;}
  |'('E')' {$$=$2;}
  ;
%%
int main()
{
 printf("\n\n\t Enter Expression : ");
 yyparse();
 return 0;
}

int yywrap()
{
 return 1;
}

int yyerror(char *err)
{
 fprintf(stderr,"%s",err);
}

/*
Output: 
exam@sitrc-OptiPlex-3010:~$ yacc -d Calc.y
exam@sitrc-OptiPlex-3010:~$ lex Calc.l
exam@sitrc-OptiPlex-3010:~$ gcc lex.yy.c y.tab.c -ll -ly -lm
exam@sitrc-OptiPlex-3010:~$ ./a.out


	 Enter Expression : 1+5*6


	 Answer = 31.000000 
exam@sitrc-OptiPlex-3010:~$ ./a.out


	 Enter Expression : (4/5*3)


	 Answer = 2.400000 
exam@sitrc-OptiPlex-3010:~$ 

