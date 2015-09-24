#include<iostream>
#include<math.h>
#include<stdlib.h>
using namespace std;
#define MAX 100

int main()
{
	int N=40;
	int number,size,i;
	cout<<"\nEnter the number of data elements\t";
	cin>>size;
	cout<<"\nEnter the number of clusters\t";
	cin>>number;
	int cluster[number][size];
	int arr[size];
	for(int i=0;i<size;i++){
	
		cout<<"\nEnter element"<<i+1<<"\t";
		cin>>arr[i];
	}

	int j,n=0;
	
	float sum[number];
	int flag[number];
	int counter[number];
	
	int m[number];
	
	//Initial means.
	
	for(i=0;i<number;i++){
		
			m[i]=arr[i];
	}
		
	//Initializing the arrays with zeroes
	
	
	
	
	//Printing the entered data sets.
	cout<<"\nThe entered data set is :\n";
	for(i=0;i<size;i++)
    	cout<<arr[i]<< "\t";
	
	cout<<"\n";
	int temp=0
;
	for(int i=0;i<size;i++)
	{
		for(int j=0;j<size-i-1;j++)
		{
			if(arr[j+1]>arr[j])
			{
				temp= arr[j];
				arr[j] = arr[j+1];
				arr[j+1] = temp;
			}		
		}
	}
	
	
	int x,y;
	do{
		n++;
		x=0;
		int j,k,temp,val=0,d[number],oldmean[number];
		for(i=0;i<number;i++) {
			sum[i]=0;
			counter[i]=0;
			flag[i]=0;
			d[i]=0;
			oldmean[i]=0;
		}
		
	 	
		for(i=0;i<number;i++){
		for(j=0;j<size;j++)
			cluster[i][j]=0;
		}
		for(i=0;i<size;i++){
			for(j=0;j<number;j++){
				d[j]=abs(arr[i]-m[j]);
			}
	
			temp=d[0];
			for(k=0;k<number;k++){
				if(d[k]<temp){
					temp=d[k];
					val=k;
				}
				
			}
			cluster[val][counter[val]]=arr[i];
				counter[val]++;
				
		}
		for(i=0;i<number;i++){
			for(j=0;j<size;j++){
				sum[i]=sum[i]+cluster[i][j];
			}		
		}

		 

		for(i=0;i<number;i++)
			oldmean[i]=m[i];			
	
		
		for(i=0;i<number;i++)
			m[i]=floor(sum[i]/counter[i]);

		for(i=0;i<number;i++){
			if(m[i]==oldmean[i]){flag[i]=1;}
			else flag[i]=0;
		}
		
		cout<<"\nOldmean\t\tNewmean:\n";

		for(i=0;i<number;i++){
			cout<<oldmean[i]<<"\t\t"<<m[i]<<"\n";
			} 
		for(i=0;i<number;i++){
			cout<<"\nAfter iteration "<<n <<" , cluster"<<i+1<<"\n";
			for(j=0;j<size;j++){
				cout<<cluster[i][j]<<"\t";
			}
		}

		
		for(i=0;i<number;i++){
			if(flag[i]==1){
				x++;}
			}
		if(x==number)
		{y=0;}
		else 
		{y=1;}

	}while(y==1);
	
	for(i=0;i<number;i++){
		cout<<"\nCluster "<<i+1<<"\n"; 
		for(j=0;j<size;j++){

			
				cout<<cluster[i][j]<<"\t";		
		}

	}
return 0;
}
/*
OUTPUT
sitrc@sitrc-OptiPlex-3020:~$ g++ k.cpp
sitrc@sitrc-OptiPlex-3020:~$ ./a.out

Enter the number of data elements	10

Enter the number of clusters	3

Enter element1	16

Enter element2	4

Enter element3	3

Enter element4	2

Enter element5	14

Enter element6	9

Enter element7	17

Enter element8	1

Enter element9	11

Enter element10	7

The entered data set is :
16	4	3	2	14	9	17	1	11	7	

Oldmean		Newmean:
16		14
4		6
3		2

After iteration 1 , cluster1
17	16	14	11	0	0	0	0	0	0	
After iteration 1 , cluster2
9	7	4	0	0	0	0	0	0	0	
After iteration 1 , cluster3
3	2	1	0	0	0	0	0	0	0	
Oldmean		Newmean:
14		14
6		6
2		2

After iteration 2 , cluster1
17	16	14	11	0	0	0	0	0	0	
After iteration 2 , cluster2
9	7	4	0	0	0	0	0	0	0	
After iteration 2 , cluster3
3	2	1	0	0	0	0	0	0	0	
Cluster 1
17	16	14	11	0	0	0	0	0	0	
Cluster 2
9	7	4	0	0	0	0	0	0	0	
Cluster 3
3	2	1	0	0	0	0	0	0	0	sitrc@sitrc-OptiPlex-3020:~$ 

*/