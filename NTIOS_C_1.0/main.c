#include "os.c"
#include "dext.c"
char kbdbuff[128];
char buffer[256];
void osstart(){
	initOS();
	println("NTIOS 1.0\r(built with SDCC)");
	while(true){
		print("> ");
		input(kbdbuff);
		system(kbdbuff);
	}
}