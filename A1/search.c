/*Assignment No : 1(Group A)
Assignment Name : Using Divide and Conquer Strategies design a function for Binary Search using C.
Class: BE					Div: B
Roll No: 56 				Batch: B3
*/


#include<stdio.h>

int max=100;

int search(int array[max], int f, int l, int mid);


void main()
{

    int array_length, loop;
    int first, last, middle;
    int i,j,temp;
    int array[max];
    printf("\nEnter number of elements you want in the array: ");
    scanf("%d", &array_length);

    printf("\nEnter %d elements for the array in ascending order: ", array_length);

    for(i=0;i<array_length;i++)
    	scanf("%d",&array[i]);
   
    for(i=0;i<array_length;i++)
	{
		for(j=0;j<array_length-i-1;j++)
		{
		if(array[j]>array[j+1])					//bubble sort 
		{
		temp=array[j];
		array[j]=array[j+1];
		array[j+1]=temp;
		}
		}
	}
    for(i=0;i<array_length;i++)
	{
		printf("%d\t",array[i]);
	} 

    first=0;
    last=array_length-1;
    middle=(first+last)/2;

    search(array, first, last, middle);
   
}


int search(int array[max], int first, int last, int middle)
{
int search;

    printf("\nEnter the number you want to search in the given array: ");
    scanf("%d", &search);

       while (first <= last) {
      if (array[middle] < search)
         first = middle + 1;    
      else if (array[middle] == search) {
         printf("%d found at location %d.\n", search, middle+1);
         break;
      }
      else
         last = middle - 1;
 
      middle = (first + last)/2;
   }
   if (first > last)
      printf("Not found! %d is not present in the list.\n", search);
 
}

/*
OUTPUT
bhushan@ubuntu:~$ gcc search.c
bhushan@ubuntu:~$ ./a.out

Enter number of elements you want in the array: 5

Enter 5 elements for the array in ascending order: 25
36
96
20
15
15	20	25	36	96	
Enter the number you want to search in the given array: 36
36 found at location 4.
bhushan@ubuntu:~$ 
*/
