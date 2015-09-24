/*Assignment No : 4(Group B)
Assignment Name : Code optimization using DAG.
Class: BE					Div: B
Roll No: 56 					Batch: B3
  */

%{
#include<stdio.h>
int yylex(void);
char r1[20],r2[20],r3[20],l[20],rr1[20],rr2[20],rr3[20],ll[20];
char w,x,y,z;
int k=0,i,j,p=0,flag[20],pk[20];
%}
%union
{
	char dval;
}
%token <dval> NUM
%token <dval> NL
%left '+' '-'
%left '*' '/'
%nonassoc UMINUS
%type <dval> S
%type <dval> E
%%

S: N '=' E LINE {}
  | {
	for(i=0;i<20;i++)  	
		pk[i]=flag[i]=0;

	
	for(i=0;i<k;i++)
	{
		for(j=i+1;j<k;j++)
		{
			if(r1[i]==r1[j] && r2[i]==r2[j] && r3[i]==r3[j] && flag[j]!=1)
			{
				flag[j]=1;
				pk[j]=i;
			}
		}
	}
	
	for(i=0;i<k;i++)
	{
		if(flag[i]!=1)
		{
			x=rr1[p]=r1[i];
			y=rr2[p]=r2[i];
			z=rr3[p]=r3[i];
			ll[p]=l[i];
			p++;
		}
		else
		{
			rr1[p]='\0';
			rr2[p]='\0';
			rr3[p]='\0';
			ll[p]='\0';
			p++;
		}
	}

	for(i=0;i<p;i++)
	{
		if(flag[i]==1)
		{
			for(j=0;j<p;j++)
			{
				if(rr1[j]==l[i])
					rr1[j]=l[pk[i]];
				if(rr3[j]==l[i])
					z=rr3[j]=l[pk[i]];
			}
		}
	}
	
	printf("\n Optimized Code is => ");
	for(i=0;i<p-1;i++)
	{
		if(ll[i]!='\0' || rr1[i]!='\0' || rr2[i]!='\0' || rr3[i]!='\0')
		{
			printf("\n %C=%C%C%C",ll[i],rr1[i],rr2[i],rr3[i]);
		}
	}
	printf("\n %C=%C%C%C",w,x,y,z);
    }
  ;
N : NUM {w=l[k]=$1;}
  ;
LINE: NL S{} | {}
;
E : NUM {$$=$1;}
  | E '+' E {r1[k]=$1;r2[k]='+';r3[k]=$3;k++;}
  | E '-' E {r1[k]=$1;r2[k]='-';r3[k]=$3;k++;}
  | E '*' E {r1[k]=$1;r2[k]='*';r3[k]=$3;k++;}
  | E '/' E {r1[k]=$1;r2[k]='/';r3[k]=$3;k++;}
  ;
%%


/**************************OUTPUT*************************
ubuntu@ubuntu:~$ yacc -d co.y
ubuntu@ubuntu:~$ lex co.l
ubuntu@ubuntu:~$ gcc lex.yy.c y.tab.c -ll -ly -lm
ubuntu@ubuntu:~$ ./a.out jpin.txt

 Optimized Code is => 
 x=a*b
 y=c*b
 p=c*bubuntu@ubuntu:~$ 


*/
