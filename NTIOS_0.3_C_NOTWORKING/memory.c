#include "memory.h"
char* heap_top;
char** heap_vars;
int vars=0;
char* alloc(int len){
	char* buf=heap_vars[vars]=heap_top;
	heap_top+=len;
    return buf;
}
void mem_setup(char* heap_bottom){
    heap_top=heap_bottom+512;
    heap_vars=heap_bottom;
    vars=0;
}
