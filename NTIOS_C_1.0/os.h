#ifndef OS_H
#define OS_H

char* qa;
char* qb;
char _c_retval;
char strcmp(char* str1, char* str2){
	qa=str1;
	qb=str2;
	__asm__ ("ld hl, (_qa)\nld de, (_qb)\ncall strcomp\nld (__c_retval), a");
	return _c_retval;
}
void print(char* s){
	qa=s;
	__asm__ ("ld hl, (_qa)\ncall ostream");
}
#endif