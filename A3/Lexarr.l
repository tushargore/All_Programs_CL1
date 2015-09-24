/*
Assignment No.3(Group A)
Assignment Name:Implementation of Lexical analyzer using Array for sample language using LEX.
Roll No.56		Div:B
Batch:B3		Date:
*/

%{
	struct SymbolTable
   	{
     		char Lexeme[200];
     		char Token[20];
         }symb[300];
   int flag=0;
%}

Comment "/*"(.|\n)*"*/"
HFile "#include<"[a-zA-Z]+"."[a-zA-z]">"
Identifier [_a-zA-Z][a-zA-Z0-9_]*
Keyword	"int"|"float"|"char"|"return"|"auto"|"break"|"case"|"const"|"continue"|"default"|"do"|"while"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"register"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile" 
Operators "+"|"-"|"*"|"/"|"%"|"<"|">"|">="|"<="|"=="|"!="|"++"|"--"|"="|"+="|"-="|"*="|"/="|"%="
SpecialOperators ","|"&"|"|"|"^"|"~"|"<<"|">>"|"&&"|"||"|"!"
Parenthesis "("|")"
Bracket "["|"]"|"{"|"}"
Constant [0-9]+|[0-9]*[.][0-9]+
Terminator ";"
WhiteSpace [ \t\n]

%%
{Comment}    		{printf("\n\t %s  			: Comment",yytext);}
{HFile} 		{printf("\n\t %s  			: Header File",yytext);}
{Keyword}    		{printf("\n\t %s  			: Keyword",yytext);}
{Identifier} 		{ if(Search(yytext)==0){Insert(yytext,"Identifier");}printf("\n\t %s			: Identifier",yytext); }
{Constant}   		{printf("\n\t %s  			: Constant",yytext);}
{Operators}  		{printf("\n\t %s  			: Operator",yytext);}
{SpecialOperators}   	{printf("\n\t %s  			: Special Operator",yytext);}
{Parenthesis}    	{printf("\n\t %s  			: parenthesis",yytext);}
{Bracket}   		{printf("\n\t %s  			: Bracket",yytext);}
{Terminator} 		{printf("\n\t %s  			: Terminator",yytext);}
{WhiteSpace}* 		;
. 			{yyerror("Lexical Error - unrecognized token",yytext);}
%%

int main(int argc,char* argv[])
{
	FILE *fp=fopen(argv[1],"r");
	
	if(fp==NULL)
	{
		yyerror("File Open Error");
	}
  	else
  	{
                yyin=fp;
    		printf("\n-----------------------------------------------------------------");
    		printf("\n\t Lexeme			:      Token");
    		printf("\n-----------------------------------------------------------------");
    		yylex();
    		fclose(fp);    
    		printf("\n-----------------------------------------------------------------\n");
    		printf("\n\t Symbol Table:");
    		printf("\n-----------------------------------------------------------------\n");
		printf("\nLexical value			Lexeme");
		Display();
  }
}

int yywrap()
{
	return 1;
}

int yyerror(char *s,char lexeme[20])
{
	fprintf(stderr," %s   %s\n",s,lexeme);
}

int Search(char lexeme[])
{
	int i;
  	for(i=0;i<flag;i++)
  	{
    		if(strcmp(symb[i].Lexeme,lexeme)==0)
    		{
      			return 1;
    		}    
  	}
   return 0;
}

int Insert(char lexeme[],char token[])
{
	strcpy(symb[flag].Lexeme,lexeme);
	strcpy(symb[flag].Token,token);
	flag++;
}

int Display()
{
  	int i;
  	for(i=0;i<flag;i++)
  	{
		printf("\n	%d			%s\n",i+1,symb[i].Lexeme);
  	}
}

/*
*******************OUTPUT***********************
bhushan@ubuntu:~$ lex Lexarr.l
bhushan@ubuntu:~$ gcc lex.yy.c
bhushan@ubuntu:~$ ./a.out Test.c

-----------------------------------------------------------------
	 Lexeme			:      Token
-----------------------------------------------------------------
	 #include<stdio.h>  	: Header File
	 int  			: Keyword
	 main			: Identifier
	 (  			: parenthesis
	 )  			: parenthesis
	 {  			: Bracket
	 int  			: Keyword
	 a			: Identifier
	 ,  			: Special Operator
	 sum			: Identifier
	 ,  			: Special Operator
	 count			: Identifier
	 ;  			: Terminator
	 if  			: Keyword
	 (  			: parenthesis
	 a			: Identifier
	 ==  			: Operator
	 sum			: Identifier
	 )  			: parenthesis
	 {  			: Bracket
	 printf			: Identifier
 Lexical Error - unrecognized token   "
	 (  			: parenthesis
	 %  			: Operator
 Lexical Error - unrecognized token   "
	 d			: Identifier
	 ,  			: Special Operator
	 home			: Identifier
	 )  			: parenthesis
	 ;  			: Terminator
	 }  			: Bracket
	 }  			: Bracket
-----------------------------------------------------------------

	 Symbol Table:
-----------------------------------------------------------------

Lexical value			Lexeme
	1			main

	2			a

	3			sum

	4			count

	5			printf

	6			d

	7			home
bhushan@ubuntu:~$
