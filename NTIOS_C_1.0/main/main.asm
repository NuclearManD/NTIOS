;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.0 #9253 (Jun 20 2015) (MINGW64)
; This file was generated Mon Jun 18 04:10:31 2018
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _osstart
	.globl _cls
	.globl _input
	.globl _println
	.globl _print
	.globl _strcmp
	.globl _kbdbuff
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_kbdbuff::
	.ds 128
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
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
;os.h:12: char strcmp(char* str1, char* str2){
;	---------------------------------
; Function strcmp
; ---------------------------------
_strcmp::
;os.h:24: __endasm;
	pop bc
	pop hl
	pop de
	push de
	push hl
	push bc
	call strcomp
	ld l, a
	ret
;os.h:26: void print(char* s){
;	---------------------------------
; Function print
; ---------------------------------
_print::
;os.h:34: __endasm;
	pop bc
	pop hl
	push hl
	push bc
	call ostream
	ret
;os.h:36: void println(char* s){
;	---------------------------------
; Function println
; ---------------------------------
_println::
;os.h:46: __endasm;
	pop bc
	pop hl
	push hl
	push bc
	call ostream
	ld a, #13
	call uart_send
	ret
;os.h:48: void input(char* sto){
;	---------------------------------
; Function input
; ---------------------------------
_input::
;os.h:56: __endasm;
	pop bc
	pop hl
	push hl
	push bc
	call uart_input
	ret
;os.h:58: void cls(){
;	---------------------------------
; Function cls
; ---------------------------------
_cls::
;os.h:62: __endasm;
	ld a, #0
	call uart_send
	ret
;main.c:3: void osstart(){
;	---------------------------------
; Function osstart
; ---------------------------------
_osstart::
;main.c:4: println("NTIOS 1.0\r(built with SDCC)");
	ld	hl,#___str_0
	push	hl
	call	_println
	pop	af
;main.c:5: while(true){
00110$:
;main.c:6: print("> ");
	ld	hl,#___str_1
	push	hl
	call	_print
;main.c:7: input(kbdbuff);
	ld	hl, #_kbdbuff
	ex	(sp),hl
	call	_input
	pop	af
;main.c:8: if(!strcmp(kbdbuff,"man")){
	ld	hl,#_kbdbuff
	ld	bc,#___str_2
	push	bc
	push	hl
	call	_strcmp
	pop	af
	pop	af
	ld	a,l
	or	a, a
	jr	NZ,00107$
;main.c:9: println("COMMANDS:\r  shutdown : halt the computer.\r  reboot : reboot the machine.");
	ld	hl,#___str_3
	push	hl
	call	_println
	pop	af
	jr	00110$
00107$:
;main.c:10: }else if(!strcmp(kbdbuff,"shutdown")){
	ld	hl,#_kbdbuff
	ld	bc,#___str_4
	push	bc
	push	hl
	call	_strcmp
	pop	af
	pop	af
	ld	a,l
	or	a, a
	ret	Z
;main.c:12: }else if(!strcmp(kbdbuff,"reboot")){
	ld	hl,#_kbdbuff
	ld	bc,#___str_5
	push	bc
	push	hl
	call	_strcmp
	pop	af
	pop	af
	ld	a,l
	or	a, a
	jr	NZ,00110$
;main.c:13: __asm jp 0 __endasm;
	jp 0 
	jr	00110$
___str_0:
	.ascii "NTIOS 1.0"
	.db 0x0D
	.ascii "(built with SDCC)"
	.db 0x00
___str_1:
	.ascii "> "
	.db 0x00
___str_2:
	.ascii "man"
	.db 0x00
___str_3:
	.ascii "COMMANDS:"
	.db 0x0D
	.ascii "  shutdown : halt the computer."
	.db 0x0D
	.ascii "  reboot : reboot "
	.ascii "the machine."
	.db 0x00
___str_4:
	.ascii "shutdown"
	.db 0x00
___str_5:
	.ascii "reboot"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
