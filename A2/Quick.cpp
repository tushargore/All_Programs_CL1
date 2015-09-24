/*
Assignment No.2(Group A)
Assignment name:Using Divide and Conquer Strategies design a class for Concurrent Quick Sort using C++.
Roll No.56		Div:B
Batch:B3		Date:
*/

#include<iostream>
#include <pthread.h>
#include <stdlib.h>

#define NOTHREADS 2
using namespace std;

int a[10];

class Node{
public:
	Node(){
                i = 0;
                j = 9;
	}
	int i;
	int j;
	void input();
	void display();
	void quick(int i, int j);
	~Node()
	{
		
	}
}NODE;

void Node::input(){
	int i = 0;
	cout<<"\nEnter 10 digits: \n";
	for (i = 0; i< 10; i++)
	{
		cin>>a[i];
	}
}

void Node::display(){
	cout<<endl<<"Sorted elements using quick sort"<<endl;
	for (i = 0; i < 10; i++)
		cout<<a[i]<<"\t";
        cout<<"\n";
}

void Node::quick(int i, int j){
        int mid = (i+j)/2;
        int ai = i;
        int bi = mid+1;
        int newa[j-i+1], newai = 0;
        while(ai <= mid && bi <= j) {
                if (a[ai] > a[bi])
                        newa[newai++] = a[bi++];
                else                    
                        newa[newai++] = a[ai++];
        }
        while(ai <= mid) {
                newa[newai++] = a[ai++];
        }
        while(bi <= j) {
                newa[newai++] = a[bi++];
        }
        for (ai = 0; ai < (j-i+1) ; ai++)
                a[i+ai] = newa[ai];
}

void * quicksort(void *a)
{
                Node *p = (Node *)a;
                Node n1, n2;
                int mid = (p->i+p->j)/2;
                pthread_t tid1, tid2;
                int ret;

                n1.i = p->i;
                n1.j = mid;

                n2.i = mid+1;
                n2.j = p->j;

                if (p->i >= p->j) return 0;

                ret = pthread_create(&tid1, NULL, quicksort, &n1);
                if (ret) {
                        cout<<"%d %s - unable to create thread - ret - %d\n", __LINE__, __FUNCTION__, ret;    
                        exit(1);
                }


                ret = pthread_create(&tid2, NULL, quicksort, &n2);
                if (ret) {
                        cout<<"%d %s - unable to create thread - ret - %d\n", __LINE__, __FUNCTION__, ret;    
                        exit(1);
                }

                pthread_join(tid1, NULL);
                pthread_join(tid2, NULL);

                NODE.quick(p->i, p->j);
                pthread_exit(NULL);
}

int main()
{
                int i;
		Node m;
		m.input();
                pthread_t tid;
                int ret; 
                ret=pthread_create(&tid, NULL, quicksort, &m);
                if (ret) {
                        cout<<"%d %s - unable to create thread - ret - %d\n", __LINE__, __FUNCTION__, ret;    
                        exit(1);
                }
                pthread_join(tid, NULL);
		m.display();
                exit(0);
}


/*

*******************OUTPUT**************************

sitrc@sitrc-OptiPlex-390:~$ g++ Quick.cpp -pthread
sitrc@sitrc-OptiPlex-390:~$ ./a.out

Enter 10 digits: 
20
33
66
65
45
20
2
13
87
77

Sorted elements using quick sort
2	13	20	20	33	45	65	66	77	87	
sitrc@sitrc-OptiPlex-390:~$ 

*/
