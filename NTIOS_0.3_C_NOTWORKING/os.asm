;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.0 #9615 (MINGW64)
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _init
	.globl _uart_print
	.globl _uart_write
	.globl _hex_conv
	.globl _vars
	.globl _heap_vars
	.globl _heap_top
	.globl _alloc
	.globl _mem_setup
	.globl _uart_println
	.globl _uart_setup
	.globl _uart_input
	.globl _strcomp
	.globl _hex_short
	.globl _hex_byte
	.globl _len
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
_UART_0	=	0x0000
_UART_1	=	0x0001
_UART_2	=	0x0002
_UART_3	=	0x0003
_UART_4	=	0x0004
_UART_5	=	0x0005
_UART_6	=	0x0006
_UART_7	=	0x0007
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_heap_top::
	.ds 2
_heap_vars::
	.ds 2
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_vars::
	.ds 2
_hex_conv::
	.ds 2
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;memory.c:5: char* alloc(int len){
;	---------------------------------
; Function alloc
; ---------------------------------
_alloc::
;memory.c:6: char* buf=heap_vars[vars]=heap_top;
	ld	hl,(_vars)
	add	hl, hl
	ld	de,(_heap_vars)
	add	hl,de
	ld	iy,#_heap_top
	ld	a,0 (iy)
	ld	(hl),a
	inc	hl
	ld	a,1 (iy)
	ld	(hl),a
	ld	bc,(_heap_top)
;memory.c:7: heap_top+=len;
	ld	hl,#2
	add	hl,sp
	push	de
	push	iy
	pop	de
	ld	a,(de)
	add	a, (hl)
	ld	(de),a
	inc	de
	ld	a,(de)
	inc	hl
	adc	a, (hl)
	ld	(de),a
	pop	de
;memory.c:8: return buf;
	ld	l, c
	ld	h, b
	ret
;memory.c:10: void mem_setup(char* heap_bottom){
;	---------------------------------
; Function mem_setup
; ---------------------------------
_mem_setup::
;memory.c:11: heap_top=heap_bottom+512;
	ld	hl,#_heap_top
	ld	iy,#2
	add	iy,sp
	ld	a,0 (iy)
	add	a, #0x00
	ld	(hl),a
	ld	a,1 (iy)
	adc	a, #0x02
	inc	hl
	ld	(hl),a
;memory.c:12: heap_vars=heap_bottom;
	ld	a,0 (iy)
	ld	(#_heap_vars + 0),a
	ld	hl, #2+1
	add	hl, sp
	ld	a, (hl)
	ld	(#_heap_vars + 1),a
;memory.c:13: vars=0;
	ld	hl,#0x0000
	ld	(_vars),hl
	ret
;uart.c:11: void uart_write(char a){
;	---------------------------------
; Function uart_write
; ---------------------------------
_uart_write::
;uart.c:12: while(!(UART_5&32));
00101$:
	in	a,(_UART_5)
	and	a, #0x20
	jr	Z,00101$
;uart.c:13: UART_0=a;
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	out	(_UART_0),a
	ret
;uart.c:15: void uart_print(char* a){
;	---------------------------------
; Function uart_print
; ---------------------------------
_uart_print::
;uart.c:17: for(i=0;a[i]!=0;i++)
	ld	bc,#0x0000
00103$:
	ld	hl, #2
	add	hl, sp
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	add	hl,bc
	ld	d,(hl)
	ld	a,d
	or	a, a
	ret	Z
;uart.c:18: uart_write(a[i]);
	push	bc
	push	de
	inc	sp
	call	_uart_write
	inc	sp
	pop	bc
;uart.c:17: for(i=0;a[i]!=0;i++)
	inc	bc
	jr	00103$
;uart.c:20: void uart_println(char* a){
;	---------------------------------
; Function uart_println
; ---------------------------------
_uart_println::
;uart.c:22: for(i=0;a[i]!=0;i++)
	ld	bc,#0x0000
00103$:
	ld	hl, #2
	add	hl, sp
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	add	hl,bc
	ld	d,(hl)
	ld	a,d
	or	a, a
	jr	Z,00101$
;uart.c:23: uart_write(a[i]);
	push	bc
	push	de
	inc	sp
	call	_uart_write
	inc	sp
	pop	bc
;uart.c:22: for(i=0;a[i]!=0;i++)
	inc	bc
	jr	00103$
00101$:
;uart.c:24: uart_write(0x0D);
	ld	a,#0x0d
	push	af
	inc	sp
	call	_uart_write
	inc	sp
	ret
;uart.c:26: void uart_setup(){
;	---------------------------------
; Function uart_setup
; ---------------------------------
_uart_setup::
;uart.c:27: UART_3=0x80;
	ld	a,#0x80
	out	(_UART_3),a
;uart.c:28: UART_0=0x0A;
	ld	a,#0x0a
	out	(_UART_0),a
;uart.c:29: UART_1=0x00;      
	ld	a,#0x00
	out	(_UART_1),a
;uart.c:30: UART_3=0x03;
	ld	a,#0x03
	out	(_UART_3),a
;uart.c:31: UART_2=0x01;
	ld	a,#0x01
	out	(_UART_2),a
;uart.c:32: uart_write(0);
	xor	a, a
	push	af
	inc	sp
	call	_uart_write
	inc	sp
	ret
;uart.c:34: void uart_input(char* buf){
;	---------------------------------
; Function uart_input
; ---------------------------------
_uart_input::
;uart.c:37: while(UART_5&1);
	ld	c,#0x00
00101$:
	in	a,(_UART_5)
	rrca
	jr	C,00101$
;uart.c:38: c=UART_0;
	in	a,(_UART_0)
;uart.c:39: if(c==0x0D)
	ld	b,a
	sub	a, #0x0d
	jr	Z,00106$
;uart.c:41: buf[i]=c;
	ld	iy,#2
	add	iy,sp
	ld	a,0 (iy)
	add	a, c
	ld	e,a
	ld	a,1 (iy)
	adc	a, #0x00
	ld	d,a
	ld	a,b
	ld	(de),a
;uart.c:36: for(i=0;i<127;i++){
	inc	c
	ld	a,c
	sub	a, #0x7f
	jr	C,00101$
00106$:
;uart.c:43: i++;
	inc	c
;uart.c:44: buf[i]=0;
	ld	hl, #2
	add	hl, sp
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	ld	b,#0x00
	add	hl, bc
	ld	(hl),#0x00
	ret
;string.c:3: unsigned char strcomp(char* a, char* b){
;	---------------------------------
; Function strcomp
; ---------------------------------
_strcomp::
	push	ix
	ld	ix,#0
	add	ix,sp
;string.c:5: for(i=0;a[i-1]!=0;i++)
	ld	bc,#0x0000
00105$:
	ld	e,c
	ld	d,b
	dec	de
	ld	l,4 (ix)
	ld	h,5 (ix)
	add	hl,de
	ld	a,(hl)
	or	a, a
	jr	Z,00103$
;string.c:6: if(a[i]!=b[i])
	ld	l,4 (ix)
	ld	h,5 (ix)
	add	hl,bc
	ld	e,(hl)
	ld	l,6 (ix)
	ld	h,7 (ix)
	add	hl,bc
	ld	d,(hl)
	ld	a,e
	sub	a, d
	jr	Z,00106$
;string.c:7: return 0;
	ld	l,#0x00
	jr	00107$
00106$:
;string.c:5: for(i=0;a[i-1]!=0;i++)
	inc	bc
	jr	00105$
00103$:
;string.c:8: return 1;
	ld	l,#0x01
00107$:
	pop	ix
	ret
;string.c:11: char* hex_short(unsigned short a){
;	---------------------------------
; Function hex_short
; ---------------------------------
_hex_short::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;string.c:12: char* buf=alloc(7);
	ld	hl,#0x0007
	push	hl
	call	_alloc
	pop	af
;string.c:13: buf[0]='0';
	ld	c,l
	ld	b,h
	ld	(hl),#0x30
;string.c:14: buf[1]='x';
	ld	l, c
	ld	h, b
	inc	hl
	ld	(hl),#0x78
;string.c:15: buf[2]=hex_conv[a>>12];
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ld	a,5 (ix)
	rlca
	rlca
	rlca
	rlca
	and	a,#0x0f
	ld	-2 (ix),a
	ld	-1 (ix),#0x00
	ld	iy,(_hex_conv)
	push	bc
	ld	c,-2 (ix)
	ld	b,-1 (ix)
	add	iy, bc
	pop	bc
	ld	a, 0 (iy)
	ld	(de),a
;string.c:16: buf[3]=hex_conv[(a>>8)&0xF];
	ld	hl,#0x0003
	add	hl,bc
	ex	(sp), hl
	ld	a, 5 (ix)
	and	a, #0x0f
	ld	e,a
	ld	d,#0x00
	ld	iy,(_hex_conv)
	add	iy, de
	ld	e, 0 (iy)
	pop	hl
	push	hl
	ld	(hl),e
;string.c:17: buf[4]=hex_conv[(a>>4)&0xF];
	ld	hl,#0x0004
	add	hl,bc
	ex	(sp), hl
	ld	e,4 (ix)
	ld	d,5 (ix)
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	ld	a,e
	and	a, #0x0f
	ld	e,a
	ld	d,#0x00
	ld	iy,(_hex_conv)
	add	iy, de
	ld	e, 0 (iy)
	pop	hl
	push	hl
	ld	(hl),e
;string.c:18: buf[5]=hex_conv[a&0xF];
	ld	hl,#0x0005
	add	hl,bc
	ex	(sp), hl
	ld	a,4 (ix)
	and	a, #0x0f
	ld	e,a
	ld	d,#0x00
	ld	iy,(_hex_conv)
	add	iy, de
	ld	e, 0 (iy)
	pop	hl
	push	hl
	ld	(hl),e
;string.c:19: buf[6]=0;
	ld	hl,#0x0006
	add	hl,bc
	ld	(hl),#0x00
;string.c:20: return buf;
	ld	l, c
	ld	h, b
	ld	sp, ix
	pop	ix
	ret
;string.c:22: char* hex_byte(unsigned char a){
;	---------------------------------
; Function hex_byte
; ---------------------------------
_hex_byte::
	push	ix
	ld	ix,#0
	add	ix,sp
	dec	sp
;string.c:23: char* buf=alloc(5);
	ld	hl,#0x0005
	push	hl
	call	_alloc
	pop	af
;string.c:24: buf[0]='0';
	ld	c,l
	ld	b,h
	ld	(hl),#0x30
;string.c:25: buf[1]='x';
	ld	l, c
	ld	h, b
	inc	hl
	ld	(hl),#0x78
;string.c:26: buf[2]=hex_conv[(a>>4)&0xF];
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ld	a,4 (ix)
	rlca
	rlca
	rlca
	rlca
	and	a,#0x0f
	and	a, #0x0f
	ld	-1 (ix),a
	ld	iy,(_hex_conv)
	push	bc
	ld	c,-1 (ix)
	ld	b,#0x00
	add	iy, bc
	pop	bc
	ld	a, 0 (iy)
	ld	(de),a
;string.c:27: buf[3]=hex_conv[a&0xF];
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
	ld	a,4 (ix)
	and	a, #0x0f
	ld	-1 (ix),a
	ld	iy,(_hex_conv)
	push	bc
	ld	c,-1 (ix)
	ld	b,#0x00
	add	iy, bc
	pop	bc
	ld	a, 0 (iy)
	ld	(de),a
;string.c:28: buf[4]=0;
	ld	hl,#0x0004
	add	hl,bc
	ld	(hl),#0x00
;string.c:29: return buf;
	ld	l, c
	ld	h, b
	inc	sp
	pop	ix
	ret
;string.c:31: int len(char* str){
;	---------------------------------
; Function len
; ---------------------------------
_len::
;string.c:33: for(i;str[i]!=0;i++);
	ld	bc,#0x0000
00103$:
	ld	hl, #2
	add	hl, sp
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	add	hl,bc
	ld	a,(hl)
	or	a, a
	jr	Z,00101$
	inc	bc
	jr	00103$
00101$:
;string.c:34: return i;
	ld	l, c
	ld	h, b
	ret
;main.c:5: void init() __critical{
;	---------------------------------
; Function init
; ---------------------------------
_init::
	ld	a,i
	di
	push	af
;main.c:6: uart_setup();
	call	_uart_setup
;main.c:7: mem_setup((char*)0x8000);
	ld	hl,#0x8000
	push	hl
	call	_mem_setup
	pop	af
	pop	af
	ret	PO
	ei
	ret
;main.c:9: void main(){
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:11: init();
	call	_init
;main.c:12: kbdbuff=alloc(128);
	ld	hl,#0x0080
	push	hl
	call	_alloc
	pop	af
;main.c:13: uart_print("Khalo le monden!");
	ld	bc,#___str_0+0
	push	hl
	push	bc
	call	_uart_print
	pop	af
	pop	hl
;main.c:14: while(true){
00104$:
;main.c:15: uart_print("> ");
	ld	bc,#___str_1+0
	push	hl
	push	bc
	call	_uart_print
	pop	af
	pop	hl
;main.c:16: uart_input(kbdbuff);
	push	hl
	push	hl
	call	_uart_input
	pop	af
	pop	hl
;main.c:17: if(strcomp(kbdbuff,"help")){
	ld	bc,#___str_2+0
	push	hl
	push	bc
	push	hl
	call	_strcomp
	pop	af
	pop	af
	ld	a,l
	pop	hl
	or	a, a
	jr	Z,00104$
;main.c:18: uart_println(" -- NTIOS 0.3 --");
	ld	bc,#___str_3+0
	push	hl
	push	bc
	call	_uart_println
	pop	af
	pop	hl
;main.c:19: uart_println("   Commands:");
	ld	bc,#___str_4+0
	push	hl
	push	bc
	call	_uart_println
	pop	af
	pop	hl
;main.c:20: uart_println("     help       | You know what this does.");
	ld	bc,#___str_5+0
	push	hl
	push	bc
	call	_uart_println
	pop	af
	pop	hl
	jr	00104$
___str_0:
	.ascii "Khalo le monden!"
	.db 0x00
___str_1:
	.ascii "> "
	.db 0x00
___str_2:
	.ascii "help"
	.db 0x00
___str_3:
	.ascii " -- NTIOS 0.3 --"
	.db 0x00
___str_4:
	.ascii "   Commands:"
	.db 0x00
___str_5:
	.ascii "     help       | You know what this does."
	.db 0x00
	.area _CODE
___str_6:
	.ascii "012356789ABCDEF"
	.db 0x00
	.area _INITIALIZER
__xinit__vars:
	.dw #0x0000
__xinit__hex_conv:
	.dw ___str_6
	.area _CABS (ABS)
