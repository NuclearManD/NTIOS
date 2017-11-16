#include "uart.h"
#include "memory.h"
__sfr __at 0x0  UART_0;
__sfr __at 0x1  UART_1;
__sfr __at 0x2  UART_2;
__sfr __at 0x3  UART_3;
__sfr __at 0x4  UART_4;
__sfr __at 0x5  UART_5;
__sfr __at 0x6  UART_6;
__sfr __at 0x7  UART_7;
void uart_write(char a){
	while(!(UART_5&32));
	UART_0=a;
}
void uart_print(char* a){
	unsigned short i;
	for(i=0;a[i]!=0;i++)
		uart_write(a[i]);
}
void uart_println(char* a){
	unsigned short i;
	for(i=0;a[i]!=0;i++)
		uart_write(a[i]);
	uart_write(0x0D);
}
void uart_setup(){
	UART_3=0x80;
	UART_0=0x0A;
	UART_1=0x00;      
	UART_3=0x03;
	UART_2=0x01;
	uart_write(0);
}
void uart_input(char* buf){
	unsigned char c,i=0;
	for(i=0;i<127;i++){
		while(UART_5&1);
		c=UART_0;
		if(c==0x0D)
			break;
		buf[i]=c;
	}
	i++;
	buf[i]=0;
}
