%{
   #include"y.tab.h"
   int line=1;
%}
Num ([0-9]+|[0-9]*"."[0-9]+)([eE][+-]?[0-9]+)?
Identifier [_a-zA-Z][_a-zA-Z0-9]*
%%
"\n" {line++;}
[ \t]+ ;
{Num} {yylval.Number=atof(yytext);return NUMBER;}
{Identifier} {strcpy(yylval.ID,yytext);return IDENTIFIER;}
"$" {return yytext[0];}
.   {return yytext[0];}
%%
void yyerror(const char *msg)
{
   printf("\n\t%s at line no %d for %s\n",msg,line,yytext);
}
