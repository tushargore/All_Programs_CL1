
%{
#include<stdio.h>
#include<string.h>
#include"y.tab.h"
%}

%%
[a-z][a-zA-Z0-9]* | 
[0-9]+                  	{
                                strcpy(yylval.vname,yytext); // take input from yacc specification file.
                                return NAME;
                        }
[ |\t]                  ;
.|\n                    { return yytext[0]; }
%%
