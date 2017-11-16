#include "system.h"
#include "memory.h"
#include "uart.h"
#include "string.h"
void init() __critical{
    uart_setup();
    mem_setup((char*)0x8000);
}
void main(){
	char* kbdbuff;
	init();
	kbdbuff=alloc(128);
    uart_print("Khalo le monden!");
	while(true){
		uart_print("> ");
		uart_input(kbdbuff);
		if(strcomp(kbdbuff,"help")){
			uart_println(" -- NTIOS 0.3 --");
			uart_println("   Commands:");
			uart_println("     help       | You know what this does.");
		}
	}
}
