#include "string.h"
#include "memory.h"
unsigned char strcomp(char* a, char* b){
	unsigned short i;
	for(i=0;a[i-1]!=0;i++)
		if(a[i]!=b[i])
			return 0;
	return 1;
}
char* hex_conv="012356789ABCDEF";
char* hex_short(unsigned short a){
	char* buf=alloc(7);
	buf[0]='0';
	buf[1]='x';
	buf[2]=hex_conv[a>>12];
	buf[3]=hex_conv[(a>>8)&0xF];
	buf[4]=hex_conv[(a>>4)&0xF];
	buf[5]=hex_conv[a&0xF];
	buf[6]=0;
	return buf;
}
char* hex_byte(unsigned char a){
	char* buf=alloc(5);
	buf[0]='0';
	buf[1]='x';
	buf[2]=hex_conv[(a>>4)&0xF];
	buf[3]=hex_conv[a&0xF];
	buf[4]=0;
	return buf;
}
int len(char* str){
	int i=0;
	for(i;str[i]!=0;i++);
	return i;
}
