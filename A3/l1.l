/*
Assignment No.3(Group A)
Assignment Name:Implementation of Lexical analyzer using Linked List for sample language using LEX.
Roll No.56		Div:B
Batch:B3		Date:
*/

%{
   #define MAX 1000
   struct SymbolTable
   {
     char Lexeme[200];
     char Token[20];
     struct SymbolTable *next;
   };
   struct SymbolTable *Header=NULL;
   struct SymbolTable* Insert(struct SymbolTable *head,char lexeme[],char token[]);
   int search(struct SymbolTable *head,char* lexeme);
   int errors=0;
%}

Comment "/*"(.|\n)*"*/"
HFile "#include<"[a-zA-Z]+"."[a-zA-z]">"
Identifier [_a-zA-Z][a-zA-Z0-9_]*
Keyword	"int"|"float"|"char"|"return"|"auto"|"break"|"case"|"const"|"continue"|"default"|"do"|"while"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"register"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile" 
Operators "+"|"-"|"*"|"/"|"%"|"<"|">"|">="|"<="|"=="|"!="|"++"|"--"|"="|"+="|"-="|"*="|"/="|"%="|"&&"|"||"|"!"
BitwiseOperators "&"|"|"|"^"|"~"|"<<"|">>"
SpecialOperators ","
Parenthesis "("|")"
SquareBracket "["|"]"
Brace "{"|"}"
Constant [0-9]+|[0-9]*[.][0-9]+
Terminator ";"
WhiteSpace [ \t\n]
%%

{Comment}             {printf("\n\t Comment     	                    :  %s\n ",yytext);  }
{HFile}               {printf("\n\t Header File                        :  %s\n ",yytext);  }
{Keyword}             {printf("\n\t Keyword                            :  %s\n ",yytext);  }
{Identifier}          {printf("\n\t Identifier                         :  %s\n ",yytext); Header=Insert(Header,yytext,"Identifier"); } 
{Constant}            {printf("\n\t Decimal Constant                   :  %s\n ",yytext);  }
{Operators} 	      {printf("\n\t Operators     	       	       :  %s \n ",yytext); }
{BitwiseOperators}    {printf("\n\t Bitwise Operator                   :  %s \n ",yytext); }
{SpecialOperators}    {printf("\n\t Special Operator                   :  %s \n ",yytext); }
{Parenthesis}         {printf("\n\t Parenthesis                        :  %s \n ",yytext); }
{SquareBracket}       {printf("\n\t Square Bracket                     :  %s \n ",yytext); }
{Brace}               {printf("\n\t Brace              	               :  %s \n ",yytext); }
{Terminator}          {printf("\n\t Terminator                         :  %s \n ",yytext); }  
{WhiteSpace}* ;
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
    		printf("\n\t Lexeme				:      Token");
    		printf("\n-----------------------------------------------------------------");
    		yylex();
    		fclose(fp);    
    		printf("\n-----------------------------------------------------------------\n");
    		printf("\n\t Symbol Table:");
    		printf("\n-----------------------------------------------------------------\n");
		printf("\n\tLexical value			Lexeme");
    		Display(Header);
  	}
}

int yywrap()
{
  	return 1;
}

int yyerror(int err,char *s)
{
  	fprintf(stderr,"\n\t Lexical Error%d 		: unrecognized token %s",errors,s);
} 

struct SymbolTable* Insert(struct SymbolTable *head,char lexeme[],char token[])
{
  	int flag=0;
  	struct SymbolTable *p,*q;
  	p=(struct SymbolTable*)malloc(sizeof(struct SymbolTable));
  	strcpy(p->Lexeme,lexeme);
  	strcpy(p->Token,token);
  	p->next=NULL;
  	if(search(head,lexeme)==1)
  	{
    		return head;
  	}
  	if(head==NULL)
  	{
    		head=p;
    		q=head;
  	}
  	else
  	{
    		q=head;
    		while(q->next!=NULL)
    		{
      			q=q->next;
    		}    
    		q->next=p;    
  	}
return head;
}

int search(struct SymbolTable *head,char* lexeme)
{
  	struct SymbolTable *q=head;
  	while(q!=NULL)
  	{
      		if(strcmp(q->Lexeme,lexeme)==0)
      		{
        		return 1;
      		}
      		q = q->next;
  	}
return 0;
}

int Display(struct SymbolTable *q)
{
  	for(;q!=NULL;q=q->next)
  	{
    		printf("\n\t %s				%s",q->Lexeme,q->Token);
  	}
  	printf("\n\n\t-----------------------------------------\n");
}

/*
  Output:
bhushan@ubuntu:~$ lex l1.l
bhushan@ubuntu:~$ gcc lex.yy.c
bhushan@ubuntu:~$ ./a.out Test.c

-----------------------------------------------------------------
	 Lexeme				    :      Token
-----------------------------------------------------------------
	 Header File                        :  #include<stdio.h>
 
	 Keyword                            :  int
 
	 Identifier                         :  main
 
	 Parenthesis                        :  ( 
 
	 Parenthesis                        :  ) 
 
	 Brace              	            :  { 
 
	 Keyword                            :  int
 
	 Identifier                         :  a
 
	 Special Operator                   :  , 
 
	 Identifier                         :  sum
 
	 Special Operator                   :  , 
 
	 Identifier                         :  count
 
	 Terminator                         :  ; 
 
	 Keyword                            :  if
 
	 Parenthesis                        :  ( 
 
	 Identifier                         :  a
 
	 Operators     	       	            :  == 
 
	 Identifier                         :  sum
 
	 Parenthesis                        :  ) 
 
	 Brace              	            :  { 
 
	 Identifier                         :  printf
 
	 Parenthesis                        :  ( 

	 Lexical Error0 		    : unrecognized token " 
	 Operators     	       	            :  % 
 
	 Identifier                         :  d

	 Lexical Error0 		    : unrecognized token " 
	 Special Operator                   :  , 
 
	 Identifier                         :  home
 
	 Parenthesis                        :  ) 
 
	 Terminator                         :  ; 
 
	 Brace              	            :  } 
 
	 Brace              	            :  } 
 
-----------------------------------------------------------------

	 Symbol Table:
-----------------------------------------------------------------

	Lexical value			Lexeme
	 main				Identifier
	 a				Identifier
	 sum				Identifier
	 count				Identifier
	 printf				Identifier
	 d				Identifier
	 home				Identifier

	-----------------------------------------
bhushan@ubuntu:~$ 


*/
