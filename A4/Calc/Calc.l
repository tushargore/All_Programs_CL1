%{
  #include"y.tab.h"
  #include<math.h>
%}
Value ([0-9]+|[0-9]*"."[0-9]+)([eE][+-]?[0-9]+)?
%%
{Value} {yylval.dval=atof(yytext);return NUMBER;}
[ \t]+ ;
.|\n {return yytext[0];}
%%
