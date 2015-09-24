/*Assignment No : 5(Group A)
Assignment Name : Int code generation for sample language using LEX and YACC.
Class: BE					Div: B
Roll No: 56 					Batch: B3
*/

%{
  #include<stdio.h>
  #include<string.h>
  int t=0;
  int sr=0;
  int Disp(char operator,char *operand1,char *operand2);
  FILE *yyin,*yyout;
%}
%union 
{
   char ID[50];
   float Number;
}
%token<ID>IDENTIFIER
%token<Number>NUMBER
%left '-' '+'
%left '*' '/'
%right '^'
%nonassoc UMINUS
%nonassoc '='
%type<ID>E
%%
S:IDENTIFIER'='E';'{Disp('=',$1,$3);yyparse();}
 |'$'{;} 
E:E'+'E {sprintf($$,"(%d)",sr);Disp('+',$1,$3);}
 |E'-'E {sprintf($$,"(%d)",sr);Disp('-',$1,$3);}
 |E'*'E {sprintf($$,"(%d)",sr);Disp('*',$1,$3);}
 |E'/'E {sprintf($$,"(%d)",sr);Disp('/',$1,$3);}
 |E'^'E {sprintf($$,"(%d)",sr);Disp('^',$1,$3);}
 |'-'E%prec UMINUS {sprintf($$,"(%d)",sr);Disp('-',$2,"");}
 |IDENTIFIER {}
 |NUMBER {sprintf($$,"%f",$1);}
 ;
%%
int main(int argc,char *argv[])
{
  FILE *fp = fopen(argv[1],"r");
  yyin=fp;
  if(fp==NULL)
  {
    yyerror("Error: File open problem\n");
  }
  else
  {
    printf("\n\t Intermediate code as per Triple");
    printf("\n\t----------------------------------------------------");
    printf("\n\tSr.\tOperator   Operand1\t  Operand2");
    printf("\n\t----------------------------------------------------");
    yyparse();
    printf("\n\t----------------------------------------------------\n");
  }
}

int yywrap()
{
 return 1;
}

int Disp(char operator,char *operand1,char *operand2)
{
  printf("\n\t (%d)\t%c\t    %s\t\t  %s\n",sr,operator,operand1,operand2);
  sr++;
}

/*
  Output:
ubuntu@ubuntu:~$ yacc -d icgt.y
ubuntu@ubuntu:~$ lex icgt.l
ubuntu@ubuntu:~$ gcc lex.yy.c y.tab.c -ll -ly -lm
ubuntu@ubuntu:~$ ./a.out INPUT.txt

	 Intermediate code as per Triple
	----------------------------------------------------
	Sr.	Operator   Operand1	  Operand2
	----------------------------------------------------
	 (0)	=	    x		  40.000000

	 (1)	*	    r		  r

	 (2)	=	    t		  (1)

	 (3)	+	    x1		  y20

	 (4)	=	    sub		  (3)

	 (5)	*	    g		  g

	 (6)	/	    (5)		  a

	 (7)	/	    s		  b

	 (8)	*	    (7)		  c

	 (9)	+	    (6)		  (8)

	 (10)	=	    d		  (9)

	 (11)	^	    n		  q

	 (12)	*	    m		  (11)

	 (13)	+	    (12)		  o

	 (14)	-	    (13)		  q

	 (15)	=	    l		  (14)

	 (16)	*	    b		  c

	 (17)	+	    a		  (16)

	 (18)	=	    g		  (17)

	 (19)	^	    y		  2.000000

	 (20)	=	    x		  (19)

	----------------------------------------------------
ubuntu@ubuntu:~$ 
*/
