#ifndef OS_H
#define OS_H

// This is basically a bunch of assembly functions
// meant to speed up your code and make programming
// easier.

#define true 1
#define false 0


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
#endif