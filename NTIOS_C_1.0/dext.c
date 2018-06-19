
/*
DEXT PROGRAMMING:

Commands and SYNTAX:

Read TXT:

(reads a text, Example:
READTxT “HELLO”.SH)

WINDOW:

(opens a new window, Example:
(OPEN)-newWINDOW=(EXAMPLE APP NAME)


CUSTOM:
(allows you to customize the size of something, Example:
newWINDOW:(CUSTOM(w,h).SH)


EUD:
command like SUDO. Example:
(EUD)-GET-UPDATE

Green:
compiles code.


Open:
opens a file or an app. Example:
(open)-“Safari"


GOTO:
goes to a location. Example:
(open)-“Safari”-(GOTO)-“https://www.google.com"



WITH:
adds something extra to a display. Example:
(displayTxT-“example” with icon 0)



SHIFT:
like the apples script command ACTIVATE. Example:
(ALPHA-APP-“Safari”)-(SHIFT)


SAND
Generates a random series of digits(add a number after the command to specify how many digits to generate). Example:
(SAND)-6


DEKTOP1:
takes a screenshot


311:
displays a list of available icons.


DisplayTXT:
displays some text. Example:
(DisplayTxT)-“Hello"


SystemINFO:
displays all the running processes on the computer. same as the bash TOP command. Example:
(GET)-(SySTEMInfo)-myCOMPUTER

FREE


ELSE:
same as the applescript command ELSE. Example:
(TxT)-“HELLO”-(atEXT)-“FIlES’-ELSE1-(atEXT)-“DESKTOP”.SH


ELSEIF:
same as applescripts’s ELSE IF. Example:
(ELSE2)-(TxT-RETURN)=“HELLO”-THEN

IF:
same as applescript’s IF command. Example:
(IF)-(TxT-RETURN)=“HELLO”-THEN

RETURN:
same as applescripts TEXT RETURNED=“”. Example:
(TxT)-(RETURN)=“HELLO”-THEN


DEFINE:
defines something. Example:
(SET)-(NewVARI):example@example.SH
(DEFINE)-(VARI):example.SH


CREATE:
creates something. Example:
(CREATE)-(VARI):example@example.SH


NVRI:
the new command for create and NEW VARI combined. Example:
(NVRI:example@__.SH)=(NewFOLDER@DESKTOP.SH).SH


VARI:
the command for variable


NEW:
makes a new something. Example:
(CREATE)-(NEW)-VARI:


NEW VARI:
creates a new variable:



CC:
copy’s the contents of something. Example:
(CC)-OF:FOLDER-“example”.SH


REPEAT:
repeats any script above it. Example:
(CC)-OF:FOLDER-“example”.SH
REPEAT

C:
sets the contents of a file to something. Example:
(C)-FIlE:SH-to”PDF”.SH


ALSO:
saves something to two locations. Example
(displayTxT-“example” with icon 0)-(atEXT)-(“example”)-Also-(atEXT)-“example”.SH

SAVE:
Saves something to somewhere. Example:
(SAVE)-(TxT)-“HELLO”-(atEXT)-TO-FILE:8SH

SEND:
Sends something to somewhere via email. Example:
(SEND)-(TxT)-“HELLO”-TO: example@example.com

FWD:
tells the computer that the previous script will continue on the next line. Example:
SAVE)-(TxT)-“HELLO”-(atEXT)-TO-(FWD)
FILE:8SH

SQUARE:
creates a square. Example:
(SQUARE:SETBoundS)-(x,y,w,h).SH

NEWCOMMAND:
creates a new command. Example:
(NEW COMMAND:CREATE)-(NEWCOMMAND)=example.SH

BY:
STANDS FOR TIMES. Example:
(SPEED)=(1P(BY)00.01 SEC.)


PX:
stands for pixels. Example:
(PX)=(x,y)

COLOR:
sets a color to something. Example:
(SET)-(COLOR)-(TO)-“example”.SH

ROTATE:
rotates something. EXAMPLE.
(ROTATE)-(SQUARE:1)-TO:(P1,P2,P3,P4)
(P1)=(x,y)
(P2)=(x,y)
(P3)=(x,y)
(P4)=(x,y)

END SET:
like END TELL.

ANI:
creates an animation. Example:
(SET)-(ANI:1)-TO: 

END SET:
like end tell.

DEXT SYNTAX by: London Almida
*/
// Intrepreter written by Dylan Brophy
/*

 [copyright here read it thx]

*/

#define VAR_NULL -1
#define VAR_INT 0
#define VAR_STR 1
#define VAR_FILE 2
#define VAR_DIR 4
#define VAR_ANM 5
#define VAR_CMD 6

#define __intlen__ sizeof(int)*100/320+2

typedef struct var{
		char* name;
		int type;
		void* data;
}var;

char* toString(var* v){
	char* out;
	switch(v->type){
		case VAR_NULL:
			return "null";
		case VAR_INT:
			out=(char*)malloc(__intlen__);
			sprintf(out,"%d",(int)v->data);
			break;
		case VAR_STR:
			out=(char*)v->data;
			break;
		case VAR_FILE:
			out=(char*)malloc(6+strlen((char*)v->data));
			sprintf(out,"File@%s",(int)v->data);
			break;
		case VAR_DIR:
			out=(char*)malloc(8+strlen((char*)v->data));
			sprintf(out,"Folder@%s",(int)v->data);
			break;
		case VAR_ANM:
			out="[Animation]";
			break;
		case VAR_CMD:
			out=(char*)malloc(5+strlen((char*)v->data));
			sprintf(out,"CMD@%s",(int)v->name);
			break;
		default:
			out="Unknown Variable Type";
	}
	return out;
}
int num_vars;
var** vars;
var nil;
char* raw;
void addVariable(var* v){
	var** tmp=(var**)malloc(sizeof(var)*(num_vars+1));
	int i;
	for(i=0;i<num_vars;i++){
		tmp[i]=vars[i];
	}
	tmp[num_vars]=v;
	vars=tmp;
	num_vars++;
}
var* getVar(char* name){
	int i;
	for(i=0;i<num_vars;i++){
		if(!strcmp(name,vars[i]->name)){
			return vars[i];
		}
	}
	return &nil;
}
char* readText(int*idx){
	char* quepie;
	int i=0;
	int l=1;
	for(i=0;(raw[idx[0]+i]<='Z'&&raw[idx[0]+i]>='A')||(raw[idx[0]+i]<='z'&&raw[idx[0]+i]>='a');i++)
		l++;
	quepie=(char*)malloc(l);
	for(i=0;(raw[idx[0]]<='Z'&&raw[idx[0]]>='A')||(raw[idx[0]]<='z'&&raw[idx[0]]>='a');idx[0]++){
		quepie[i]=raw[idx[0]];
		i++;
	}
	quepie[i]=0;
	return quepie;
}
int readNumber(int*idx){
	char* quepie;
	int i;
	int l=1;
	for(i=0;(raw[idx[0]+i]!=' '&&raw[idx[0]+i]!='\r'&&raw[idx[0]+i]!='\n'&&raw[idx[0]+i]!='\t'&&raw[idx[0]+i]!=0);i++)
		l++;
	quepie=(char*)malloc(l);
	for(i=0;(raw[idx[0]]!=' '&&raw[idx[0]]!='\r'&&raw[idx[0]]!='\n'&&raw[idx[0]]!='\t'&&raw[idx[0]]!=0);idx[0]++){
		quepie[i]=raw[idx[0]];
		i++;
	}
	quepie[i]=0;
	return atoi(quepie);
}
char* readExpression(int*idx);
var* resolveExpression(int*idx){
	char a=raw[idx[0]];
	var* out=(var*)malloc(sizeof(var));
	char* quepie;
	char* name;
	int i;
	int l;
	if((a<='Z'&&a>='A')||(a<='z'&&a>='a')){
		name=readText(idx);
		if(!strcmp(name,"NewFOLDER")){
			out->type=VAR_DIR;
			if(raw[idx[0]]!='@'){
				println("Bad NewFOLDER constructor;");
				return &nil;
			}
			idx[0]++;
			out->data=(void*)readExpression(idx);
		}else if(!strcmp(name,"NewFILE")){
			out->type=VAR_FILE;
			if(raw[idx[0]]!='@'){
				println("Bad NewFILE constructor;");
				return &nil;
			}
			idx[0]++;
			out->data=(void*)readExpression(idx);
		}else
			out=getVar(name);
		return out;
	}else if(a>='0'&&a<='9'){
		i=readNumber(idx);
		out->type=VAR_INT;
		out->data=(void*)i;
		return out;
	}else if(a=='"'){
		idx[0]++;
		i=0;
		for(;(raw[i]!='"');i++)
			l++;
		quepie=(char*)malloc(l);
		for(i=0;(raw[idx[0]]!='"');idx[0]++){
			quepie[i]=raw[idx[0]];
			i++;
		}
		quepie[i]=0;
		out->type=VAR_STR;
		out->data=(void*)quepie;
		return out;
	}else{
		return &nil;
	}
}
char* readExpression(int*idx){
	var* v=resolveExpression(idx);
	return toString(v);
}
int parse(int idx){
	char c=raw[idx];
	char* t;
	var* tmp;
	var* x;
	while(c==' '||c=='\r'||c=='\n'||c=='\t'){
		idx++;
		c=raw[idx];
	}
	if(c=='/'&&raw[idx+1]=='/'){
		while(c!='\n'){
			idx++;
			c=raw[idx];
		}
		return idx;
	}
	// start of a command
	t=readText(&idx);
	if(!strcmp(t,"NVRI")){
		if(raw[idx]==':'){
			idx++;
			tmp=(var*)malloc(sizeof(var));
			tmp->name=readText(&idx);
			if(raw[idx]=='='){
				idx++;
				x=resolveExpression(&idx);
				tmp->type=x->type;
				tmp->data=x->data;
			}
			addVariable(tmp);
		}else
			println("invalid syntax!");
	}else if(!strcmp(t,"ECHO")){
		if(raw[idx]==':'){
			idx++;
			println(readExpression(&idx));
		}
	}else{
		x=getVar(t);
		if(raw[idx]==':'){
			idx++;
			free(t);
			t=readText(&idx);
			switch(x->type){
				case VAR_INT:
					if(!strcmp(t,"INC")){
						x->data=(void*)((int)x->data+1);
					}else if(!strcmp(t,"DEC")){
						x->data=(void*)((int)x->data-1);
					}
					break;
				case VAR_STR:
					break;
				case VAR_FILE:
					if(!strcmp(t,"READ")){
						//mkdir((char*)x->data);
					}else if(!strcmp(t,"WRITE")){
						//mkdir((char*)x->data);
					}else if(!strcmp(t,"DELETE")){
						println("ERROR: 'delete' not yet supported.");
					}
				case VAR_DIR:
					if(!strcmp(t,"CREATE")){
						//mkdir((char*)x->data);
					}
				default:
					break;
			}
		}
	}
	free(t);
	return idx;
}
int dext(int argc, char** argv){
	int idx=0;
	num_vars=0;
	//if(argc<=1){
	//	println("Usage: DEXTS [filename]");
	//	return -1;
	//}
	raw="ECHO:\"Hello World!!!!!\"";//readFile(argv[1]);
	if(raw==(char*)NULL){
		println("Error: file not found!");
		return -2;
	}
	// setup here
	nil.name="null";
	nil.type=VAR_NULL;
	nil.data=(void*)"null";
	addVariable(&nil);
	
	while(idx<strlen(raw)){
		idx=parse(idx);
		idx++;
	}
	return 0;
}