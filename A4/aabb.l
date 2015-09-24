%{
  #include"y.tab.h"
%}
%%
a {return M;}
b {return S;}
\n {return yytext[0];}
%%
