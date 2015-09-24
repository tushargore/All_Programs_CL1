/*Assignment No: D2(Elective I)(Group B)
Assignment Name: Implement Apriori approach for datamining to organize the data items on a shelf using following table of items purchased in a Mall
Transaction_ID    Item1    Item2    Item3    Item4    Item5      Item6
      T1          Mango    Onion     Jar    Key-chain  Eggs   Chocolates
	T2 		Nuts 	   Onion     Jar    Key-chain  Eggs   Chocolates
	T3 		Mango    Apple  Key-chain   Eggs      -          -
	T4 		Mango  Toothbrush  Corn   Key-chain Chocolates   -
      T5          Corn     Onion     Onion  Key-chain  Knife     Eggs
*/

#include "bits/stdc++.h"

using namespace std;

#define structure map<vector<int>, int>
#define FOR_MAP(ii,T) for(structure::iterator (ii)=(T).begin();(ii)!=(T).end();(ii)++)
#define FOR_next_MAP(jj,ii,T) for(structure::iterator (jj)=(ii);(jj)!=(T).end();(jj)++)
#define VI vector<int>

//const int MIN_SUP = 2;
int x;
structure C;
structure L;

void C1();
void L1();
void generate_C();
void generate_L();
void output(structure, char, int);
void scan_D();
bool check_compatibility(VI ,VI );
void set_count(VI );

int main(int argc, char const *argv[])
{
	C.clear();
	L.clear();
	char ch = ' ';
	cout<<"\n\nConsider The items as:";
	cout<<"\n\nMango : 1\nOnion : 2\nJar : 3\nKey-chain : 4\n";
	cout<<"Egg : 5\n";
	cout<<"Chocolate : 6\n";
	cout<<"Nuts : 7\n";
	cout<<"Apple : 8\n";
	cout<<"Toothbrush : 9\n";
	cout<<"Corn : 10\n";
	cout<<"Knife : 11\n";
	cout<<"\n\nEnter the minimun support:";
	cin>>x;
	bool mv=true;
	int index=1;
	while(true)
	{
		if (mv)
		{
			C1();
			ch = 'C';
			output(C,ch, index);

			L1();
			ch = 'L';
			output(L,ch, index);
			index ++ ;
			mv=!mv;
		}else
		{
			generate_C();
			if(C.size()==0)
				break;
			scan_D();
			ch = 'C';
			output(C, ch,index);
			generate_L();
			if (L.size()==0)
			{
				break;
			}
			ch = 'L';
			output(L,ch,index);
			index++;
		}
	}
	return 0;
}


void C1()
{
	ifstream fin;
	fin.open("input.txt");
	if(!fin)
		{
			cout<<"Input file opening error\n";
			exit(0);
		}

	int n;
	VI v;
	while(fin>>n)
	{
		v.clear();
		if (n==-1)
		{
			continue;
		}
		v.push_back(n);
		if(C.count(v)>0)
			C[v]++;
		else
			C[v]=1;
	}
	fin.close();
}

void output(structure T, char ch, int index)
{
	cout<<"\n";
	VI v;
	int temp = 0;
	FOR_MAP(ii,T)
	{
		v.clear();
		v=ii->first;
		
		if(ii->second >= x)//MIN_SUP)
		{
			if (temp == 0)
			{cout<<ch<<index<<endl; temp = 1;	}
			for (int i = 0; i < v.size(); ++i)
			{
				cout<<v[i]<<" ";
			}
			
			cout<<" ---(frequency)----->> "<<ii->second;
			cout<<"\n";
		}

	}
temp = 0;	
}

void L1()
{

	FOR_MAP(ii,C)
	{
		if (ii->second >= x)//MIN_SUP)
		{
			L[ii->first]=ii->second;
		}
	}

}

void generate_C()
{
	//clean(C);
	C.clear();
	FOR_MAP(ii,L)
	{

		FOR_next_MAP(jj,ii,L)
		{
			if(jj==ii)
				continue;
			VI a,b;
			a.clear();
			b.clear();
			a=ii->first;
			b=jj->first;
			if(check_compatibility(a,b))	
			{
				a.push_back(b.back());
				sort(a.begin(), a.end());
				C[a]=0;
			}
		}

	}


}

bool check_compatibility(VI a,VI b)
{
	bool compatible=true;
	for (int i = 0; i < a.size()-1; ++i)
	{
		if (a[i]!=b[i])
		{
			compatible=false;
			break;
		}
	}

	return compatible;
}

void scan_D()
{
	ifstream fin;
	fin.open("input.txt");
	if(!fin)
		{
			cout<<"Input file opening error\n";
			exit(0);
		}

	int n;
	VI a;
	while(fin>>n)
	{
		if(n==-1 && a.size()>0)
		{
			set_count(a);
			a.clear();
		}else if(n!=-1)
		{
			a.push_back(n);
		}
		
	}
	fin.close();
}

void set_count(VI a)
{
	FOR_MAP(ii,C)
	{
		VI b;
		b.clear();
		b=ii->first;
		int true_count=0;
		if (b.size()<=a.size())
		{
			for (int i = 0; i < b.size(); ++i)
			{
				for (int j = 0; j < a.size(); ++j)
				{
					if(b[i]==a[j])
					{
						true_count++;
						break;
					}
				}
			}
		}

		if (true_count==b.size())
		{
			ii->second++;
		}
	}
}

void generate_L()
{
	L.clear();

	FOR_MAP(ii,C)
	{
		if(ii->second >= x)//MIN_SUP)
		{
			L[ii->first]=ii->second;
		}
	}
}

/*****************************OUTPUT*******************************
ubuntu@ubuntu:~$ g++ apriori.cpp
ubuntu@ubuntu:~$ ./a.out


Consider The items as:

Mango : 1
Onion : 2
Jar : 3
Key-chain : 4
Egg : 5
Chocolate : 6
Nuts : 7
Apple : 8
Toothbrush : 9
Corn : 10
Knife : 11


Enter the minimun support:2

C1
1  ---(frequency)----->> 5
2  ---(frequency)----->> 2
3  ---(frequency)----->> 2
4  ---(frequency)----->> 5
5  ---(frequency)----->> 4
6  ---(frequency)----->> 3
10  ---(frequency)----->> 2

L1
1  ---(frequency)----->> 5
2  ---(frequency)----->> 2
3  ---(frequency)----->> 2
4  ---(frequency)----->> 5
5  ---(frequency)----->> 4
6  ---(frequency)----->> 3
10  ---(frequency)----->> 2

C2
1 4  ---(frequency)----->> 4
1 5  ---(frequency)----->> 3
1 6  ---(frequency)----->> 2
1 10  ---(frequency)----->> 2
2 3  ---(frequency)----->> 2
2 4  ---(frequency)----->> 2
2 5  ---(frequency)----->> 2
2 6  ---(frequency)----->> 2
3 4  ---(frequency)----->> 2
3 5  ---(frequency)----->> 2
3 6  ---(frequency)----->> 2
4 5  ---(frequency)----->> 4
4 6  ---(frequency)----->> 3
4 10  ---(frequency)----->> 2
5 6  ---(frequency)----->> 2

L2
1 4  ---(frequency)----->> 4
1 5  ---(frequency)----->> 3
1 6  ---(frequency)----->> 2
1 10  ---(frequency)----->> 2
2 3  ---(frequency)----->> 2
2 4  ---(frequency)----->> 2
2 5  ---(frequency)----->> 2
2 6  ---(frequency)----->> 2
3 4  ---(frequency)----->> 2
3 5  ---(frequency)----->> 2
3 6  ---(frequency)----->> 2
4 5  ---(frequency)----->> 4
4 6  ---(frequency)----->> 3
4 10  ---(frequency)----->> 2
5 6  ---(frequency)----->> 2

C3
1 4 5  ---(frequency)----->> 3
1 4 6  ---(frequency)----->> 2
1 4 10  ---(frequency)----->> 2
2 3 4  ---(frequency)----->> 2
2 3 5  ---(frequency)----->> 2
2 3 6  ---(frequency)----->> 2
2 4 5  ---(frequency)----->> 2
2 4 6  ---(frequency)----->> 2
2 5 6  ---(frequency)----->> 2
3 4 5  ---(frequency)----->> 2
3 4 6  ---(frequency)----->> 2
3 5 6  ---(frequency)----->> 2
4 5 6  ---(frequency)----->> 2

L3
1 4 5  ---(frequency)----->> 3
1 4 6  ---(frequency)----->> 2
1 4 10  ---(frequency)----->> 2
2 3 4  ---(frequency)----->> 2
2 3 5  ---(frequency)----->> 2
2 3 6  ---(frequency)----->> 2
2 4 5  ---(frequency)----->> 2
2 4 6  ---(frequency)----->> 2
2 5 6  ---(frequency)----->> 2
3 4 5  ---(frequency)----->> 2
3 4 6  ---(frequency)----->> 2
3 5 6  ---(frequency)----->> 2
4 5 6  ---(frequency)----->> 2

C4
2 3 4 5  ---(frequency)----->> 2
2 3 4 6  ---(frequency)----->> 2
2 3 5 6  ---(frequency)----->> 2
2 4 5 6  ---(frequency)----->> 2
3 4 5 6  ---(frequency)----->> 2

L4
2 3 4 5  ---(frequency)----->> 2
2 3 4 6  ---(frequency)----->> 2
2 3 5 6  ---(frequency)----->> 2
2 4 5 6  ---(frequency)----->> 2
3 4 5 6  ---(frequency)----->> 2

C5
2 3 4 5 6  ---(frequency)----->> 2

L5
2 3 4 5 6  ---(frequency)----->> 2
ubuntu@ubuntu:~$ 
*/
