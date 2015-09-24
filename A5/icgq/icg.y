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
  int Disp(char *operator,char *operand1,char *operand2,char *Result);
  FILE *yyin,*yyout;
%}
%union 
{
   char ID[50];
   float Number;
}
%token<ID>IDENTIFIER
%token<Number>NUMBER
%token LE GE EQ NE OR AND PLUSASSIGN MINUSASSIGN MULTIPLYASSIGN DIVIDEASSIGN MODASSIGN
%token BITWISEANDASSIGN XORASSIGN ORASSIGN LEFTSHIFTASSIGN RIGHTSHIFTASSIGN
%left ','
%right PLUSASSIGN MINUSASSIGN MULTIPLYASSIGN DIVIDEASSIGN MODASSIGN BITWISEANDASSIGN XORASSIGN ORASSIGN LEFTSHIFTASSIGN RIGHTSHIFTASSIGN
%left OR AND
%left '&' '|'
%left EQ NE
%left '<' '>' LE GE
%left SHIFTLEFT SHIFTRIGHT
%left '-' '+'
%left '*' '/'
%right '^'
%nonassoc UMINUS
%nonassoc '='
%type<ID>E
%%
S:IDENTIFIER'='E';'{Disp("=",$3,"",$1);yyparse();}
 |'$'{;} 
E:E'+'E {sprintf($$,"t%d",t++);Disp("+",$1,$3,$$);}
 |E'-'E {sprintf($$,"t%d",t++);Disp("-",$1,$3,$$);}
 |E'*'E {sprintf($$,"t%d",t++);Disp("*",$1,$3,$$);}
 |E'/'E {sprintf($$,"t%d",t++);Disp("/",$1,$3,$$);}
 |E'<'E {sprintf($$,"t%d",t++);Disp("<",$1,$3,$$);}
 |E'>'E {sprintf($$,"t%d",t++);Disp(">",$1,$3,$$);}
 |E LE E {sprintf($$,"t%d",t++);Disp("<=",$1,$3,$$);}
 |E GE E {sprintf($$,"t%d",t++);Disp(">=",$1,$3,$$);}
 |E EQ E {sprintf($$,"t%d",t++);Disp("==",$1,$3,$$);}
 |E NE E {sprintf($$,"t%d",t++);Disp("!=",$1,$3,$$);}
 |E OR E {sprintf($$,"t%d",t++);Disp("||",$1,$3,$$);}
 |E AND E {sprintf($$,"t%d",t++);Disp("&&",$1,$3,$$);}
 |E '&' E {sprintf($$,"t%d",t++);Disp("&",$1,$3,$$);}
 |E '|' E {sprintf($$,"t%d",t++);Disp("|",$1,$3,$$);}
 |E'^'E {sprintf($$,"t%d",t++);Disp("^",$1,$3,$$);}
 |E SHIFTRIGHT E {sprintf($$,"t%d",t++);Disp(">>",$1,$3,$$);}
 |E SHIFTLEFT E {sprintf($$,"t%d",t++);Disp("<<",$1,$3,$$);}
 |E ',' E {sprintf($$,"t%d",t++);Disp(",",$1,$3,$$);}
 |E PLUSASSIGN E {sprintf($$,"t%d",t++);Disp("+=",$1,$3,$$);}
 |E MINUSASSIGN E {sprintf($$,"t%d",t++);Disp("-=",$1,$3,$$);}
 |E MULTIPLYASSIGN E {sprintf($$,"t%d",t++);Disp("*=",$1,$3,$$);}
 |E DIVIDEASSIGN E {sprintf($$,"t%d",t++);Disp("/=",$1,$3,$$);}
 |E MODASSIGN E {sprintf($$,"t%d",t++);Disp("%=",$1,$3,$$);}
 |E BITWISEANDASSIGN E {sprintf($$,"t%d",t++);Disp("&=",$1,$3,$$);}
 |E XORASSIGN E {sprintf($$,"t%d",t++);Disp("^=",$1,$3,$$);}
 |E ORASSIGN E {sprintf($$,"t%d",t++);Disp("|=",$1,$3,$$);}
 |E LEFTSHIFTASSIGN E {sprintf($$,"t%d",t++);Disp("<<=",$1,$3,$$);}
 |E RIGHTSHIFTASSIGN E {sprintf($$,"t%d",t++);Disp(">>=",$1,$3,$$);}
 |'-'E%prec UMINUS {sprintf($$,"t%d",t++);Disp("-",$2,"",$$);}
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
    printf("\n\t Intermediate code as per Quadruple");
    printf("\n\t----------------------------------------------------");
    printf("\n\tSr.\t Operator   Operand1\t  Operand2\t  Result");
    printf("\n\t----------------------------------------------------");
    yyparse();
    printf("\n\t----------------------------------------------------\n");
  }
}

int yywrap()
{
 return 1;
}

int Disp(char *operator,char *operand1,char *operand2,char *Result)
{
  printf("\n\t (%d)\t%s\t    %s\t\t  %s\t\t %s\n",sr,operator,operand1,operand2,Result); 
  sr++;
}

/*
Output:
ubuntu@ubuntu:~$ yacc -d icg.y
ubuntu@ubuntu:~$ lex icg.l
ubuntu@ubuntu:~$ gcc lex.yy.c y.tab.c -ll -ly -lm
ubuntu@ubuntu:~$ ./a.out Test.txt

	 Intermediate code as per Quadruple
	----------------------------------------------------
	Sr.	 Operator   Operand1	  Operand2	  Result
	----------------------------------------------------
	 (0)	+	    sum		  40.000000		 t0

	 (1)	=	    t0		  		 sum

	 (2)	<	    p		  q		 t1

	 (3)	=	    t1		  		 x

	 (4)	<=	    p		  q		 t2

	 (5)	=	    t2		  		 y

	 (6)	&&	    m		  q		 t3

	 (7)	=	    t3		  		 l

	 (8)	<	    p		  q		 t4

	 (9)	>	    m		  q		 t5

	 (10)	&&	    t4		  t5		 t6

	 (11)	=	    t6		  		 f

	 (12)	<	    q		  p		 t7

	 (13)	|	    p		  t7		 t8

	 (14)	=	    t8		  		 x

	 (15)	<=	    p		  l		 t9

	 (16)	&	    d		  t9		 t10

	 (17)	=	    t10		  		 l

	 (18)	<<	    p		  2.000000		 t11

	 (19)	=	    t11		  		 l

	 (20)	>>	    l		  2.000000		 t12

	 (21)	=	    t12		  		 q

	 (22)	<<	    p		  2.000000		 t13

	 (23)	>>	    t13		  1.000000		 t14

	 (24)	=	    t14		  		 r

	 (25)	,	    sum		  b		 t15

	 (26)	,	    t15		  q		 t16

	 (27)	,	    t16		  f		 t17

	 (28)	=	    t17		  		 r

	 (29)	-=	    x		  10.000000		 t18

	 (30)	=	    t18		  		 p

	 (31)	^=	    d		  z		 t19

	 (32)	=	    t19		  		 m

	 (33)	%=	    s		  2.000000		 t20

	 (34)	=	    t20		  		 n

	----------------------------------------------------
ubuntu@ubuntu:~$ 
*/
