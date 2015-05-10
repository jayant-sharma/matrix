#include<stdio.h>
//#include<iostream.h>

#define ROW1	3
#define COL1	3
#define ROW2	COL1
#define COL2	3


int main()
{
	int i,j,k,l;
	int temp=0;	
	int N1 = ROW1*COL1;
	int N2 = ROW2*COL2;
	int N3 = ROW1*COL2;

	char mat1[9] = {	0x00, 0x01, 0x02, 
				0x03, 0x04, 0x05, 
				0x06, 0x07, 0x08	};
						
	char mat2[9] = {	0x10, 0x11, 0x12,
				0x13, 0x14, 0x15,
				0x16, 0x17, 0x17	};
						
	unsigned long mat3[9];
	
	for(j=0; j<ROW1; j++){
		for(k=0; k<COL2; k++){
			for(l=0; l<COL1; l++){
				temp = temp + (mat1[l+j*COL1])*(mat2[k+l*COL2]);
			}
			mat3[k+j*COL2] = temp;
			temp = 0;
		}
	}

	for(i=0; i<N3; i++){
		printf("0x%x\t",mat3[i]);
		printf("\n");
	}
}
