;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.0 #9253 (Jun 20 2015) (MINGW64)
; This file was generated Sun Jun 17 15:14:40 2018
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _osstart
	.globl _print
	.globl _strcmp
	.globl __c_retval
	.globl _qb
	.globl _qa
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_qa::
	.ds 2
_qb::
	.ds 2
__c_retval::
	.ds 1
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
;os.h:7: char strcmp(char* str1, char* str2){
;	---------------------------------
; Function strcmp
; ---------------------------------
_strcmp::
;os.h:8: qa=str1;
	ld	iy,#2
	add	iy,sp
	ld	a,0 (iy)
	ld	iy,#_qa
	ld	0 (iy),a
	ld	iy,#2
	add	iy,sp
	ld	a,1 (iy)
	ld	iy,#_qa
	ld	1 (iy),a
;os.h:9: qb=str2;
	ld	iy,#4
	add	iy,sp
	ld	a,0 (iy)
	ld	iy,#_qb
	ld	0 (iy),a
	ld	iy,#4
	add	iy,sp
	ld	a,1 (iy)
	ld	iy,#_qb
	ld	1 (iy),a
;os.h:10: __asm__ ("ld hl, (_qa)\nld de, (_qb)\ncall strcomp\nld (__c_retval), a");
	ld hl, (_qa)
	ld de, (_qb)
	call strcomp
	ld (__c_retval), a
;os.h:11: return _c_retval;
	ld	iy,#__c_retval
	ld	l,0 (iy)
	ret
;os.h:13: void print(char* s){
;	---------------------------------
; Function print
; ---------------------------------
_print::
;os.h:14: qa=s;
	ld	iy,#2
	add	iy,sp
	ld	a,0 (iy)
	ld	iy,#_qa
	ld	0 (iy),a
	ld	iy,#2
	add	iy,sp
	ld	a,1 (iy)
	ld	iy,#_qa
	ld	1 (iy),a
;os.h:15: __asm__ ("ld hl, (_qa)\ncall ostream");
	ld hl, (_qa)
	call ostream
	ret
;main.c:2: void osstart(){
;	---------------------------------
; Function osstart
; ---------------------------------
_osstart::
;main.c:3: print("Hello World!!");
	ld	hl,#___str_0
	push	hl
	call	_print
	pop	af
	ret
___str_0:
	.ascii "Hello World!!"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
