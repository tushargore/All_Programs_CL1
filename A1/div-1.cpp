/*Assignment No : 1(Group A)
Assignment Name : Using Divide and Conquer Strategies design a function for Binary Search using C++.
Class: BE					Div: B
Roll No: 57 				Batch: B3
*/


#include<iostream>
using namespace std;

int main()
{
	int arr[10],x,left,right,n,mid,flag=0;
	int i;

	cout<<"How many elements you want to enter : ";
	cin>>n;
 
	if(n>10)
	{
		cout<<"Array overflow\n";
	}
	else
	{
	cout<<"Enter array elements : ";
	for( i=0;i<n;i++)
	{
		cin>>arr[i];
	}

	cout<<"Enter number which you want to search : ";
	cin>>x;

	left=0,right=n-1;
	while(left<=right)
	{
		mid=(left+right)/2;
		if(arr[mid]==x)
		{
			flag=1;
			break;
		}
		
		else if(x<arr[mid])
		{
			right=mid-1;
		}
		else
		left=mid+1;
	}

	if(flag==1)
	{
		cout<<"\nNumber found\n";
	}
	else
		cout<<"\nNumber not found\n";
}
return 0;
}

/*
OUTPUT
prygma>>g++ div.cpp
prygma>>./a.out
How many elements you want to enter : 5
Enter array elements : 45
55
23
20
99
Enter number which you want to search : 23

Number found
prygma>>./a.out
How many elements you want to enter : 5
Enter array elements : 78
99
56
45
34
Enter number which you want to search : 57

Number not found
prygma>> 
*/
