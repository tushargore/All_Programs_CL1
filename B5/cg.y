/*Assignment No : 5(Group B)
Assignment Name : Code generation using DAG / labeled tree.
Class: BE					Div: B
Roll No: 56 					Batch: B3
  */

%{ //Declaration section
// Declare the header files and pointers here
#include<stdlib.h>            
#include<stdio.h>
FILE *fpOut,*yyout,*yyin;
%}

%union
{
        char vname[10];     
}
%left '+' '-'
%left '*' '/'
%token<vname>NAME
%type<vname>expression
%type<vname>line

%% //Rule section
//Declare the grammer here
input   : line '\n' input
          | '\n' input
          | ;
line    : NAME '=' expression  {
                                  fprintf(fpOut,"MOV %s, AX\n",$1);
                               }
        ;
expression : NAME '+' NAME      {
                                  fprintf(fpOut,"MOV AX, %s\n",$1);
                                  fprintf(fpOut,"ADD AX, %s\n",$3);
                               }
          | NAME '-' NAME      {
                                  fprintf(fpOut,"MOV AX, %s\n",$1);
                                  fprintf(fpOut,"SUB AX, %s\n",$3);
                               }
          | NAME '*' NAME      {
                                  fprintf(fpOut,"MOV AX, %s\n",$1);
                                  fprintf(fpOut,"MUL AX, %s\n",$3);
                               }

          | NAME '/' NAME      {
                                  fprintf(fpOut,"MOV AX, %s\n",$1);
                                  fprintf(fpOut,"DIV AX, %s\n",$3);
                               }
          | NAME               {
                                  fprintf(fpOut,"MOV AX, %s\n",$1);
                                  //strcpy($$, $1);
                               }
          ;
%%

FILE *yyin;
// C subroutine section
main()
{
        FILE *fpInput;
        fpInput = fopen("input1.txt","r");
        if(fpInput=='\0')
        {
                yyerror("file read error");
                exit(0);
        }
        fpOut = fopen("output1.txt","w");
        if(fpOut=='\0')
        {
                yyerror("file creation error");
                exit(0);
        }
        yyin = fpInput;
        yyout=fpOut;
        yyparse();
        fcloseall();
}
yyerror(char *msg)
{
        fprintf(stderr,"%s",msg);
}
