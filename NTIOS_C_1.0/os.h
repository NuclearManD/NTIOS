#ifndef OS_H
#define OS_H

// This is basically a bunch of assembly functions
// meant to speed up your code and make programming
// easier.

#define true 1
#define false 0

#define NULL -404

#define HEAP_SIZE 1600

char heap[HEAP_SIZE];
int heap_loc=0;
char strcmp(char* str1, char* str2){
	str1;
	str2;
	__asm
	pop bc
	pop hl
	pop de
	push de
	push hl
	push bc
	call strcomp
	ld l, a
	__endasm;
}
int strlen(char* str1){
	str1;
	__asm
	pop bc
	pop hl
	push hl
	push bc
	call strlen
	ld l, c
	ld h, b
	__endasm;
}
void print(char* s){
	s;
	__asm
	pop bc
	pop hl
	push hl
	push bc
	call ostream
	__endasm;
}
void println(char* s){
	s;
	__asm
	pop bc
	pop hl
	push hl
	push bc
	call ostream
	ld a, #13
	call uart_send
	__endasm;
}
void input(char* sto){
	sto;
	__asm
	pop bc
	pop hl
	push hl
	push bc
	call uart_input
	__endasm;
}
void cls(){
	__asm
	ld a, #0
	call uart_send
	__endasm;
}
char* malloc(int size){
	char* q=(char*)((int)heap+heap_loc);
	heap_loc+=size;
	return q;
}
void free(char* q){
	q;
}
int memFree(){
	return HEAP_SIZE-heap_loc;
}
int atoi(char* str){
	int len=strlen(str);
	int i=0;
	int o=0;
	for(i=0;i<len;i++){
		o*=10;
		o+=str[i]-48;
	}
	return o;
}
int itoa(char* out, int n){
	char* tmp=(char*)"-65535";
	int i=0;
	int r=-1;
	int j;
	for(i=0;i<6;i++){
		tmp[i]=48+(n%10);
		n=n/10;
		if(n==0){
			r=i;
			break;
		}
	}
	j=(n>>15)+6;
	if(n<0)
		out[0]='-';
	for(;i>=0;i--){
		out[j-i]=tmp[i];
	}
	return r;
}
void sprintf(char* out, char* fmt, int x){
	int i,j;
	int idx=0;
	for(i=0;fmt[i]!=0;){
		if(fmt[i]=='%'){
			i++;
			if(fmt[i]=='d'){
				itoa(out+i,x);
			}else if(fmt[i]=='s'){
				for(j=0;((char*)x)[j]!=0;j++){
					out[idx]=((char*)x)[j];
					idx++;
				}
			}
		}else{
			out[idx]=fmt[i];
			idx++;
		}
	}
}
#endif