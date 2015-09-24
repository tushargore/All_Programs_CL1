%{
#include<stdio.h>
#include<math.h>
#include "y.tab.h"
%}
%%
[a-zA-Z0-9] {yylval.dval=yytext[0];return NUM;}
[\t];
\n return NL;
. {return yytext[0];}
%%
void yyerror(char *str)
{
	printf("\n Invalid...");
}
int main()
{
	yyin=fopen("jpin.txt","r");
	yyparse();
	return(0);
}
int yywrap()
{
	return 1;
}
