#include "os.h"
char kbdbuff[128];
void osstart(){
	println("NTIOS 1.0\r(built with SDCC)");
	while(true){
		print("> ");
		input(kbdbuff);
		if(!strcmp(kbdbuff,"man")){
			println("COMMANDS:\r  shutdown : halt the computer.\r  reboot : reboot the machine.");
		}else if(!strcmp(kbdbuff,"shutdown")){
			break;
		}else if(!strcmp(kbdbuff,"reboot")){
			__asm jp 0 __endasm;
		}
	}
}