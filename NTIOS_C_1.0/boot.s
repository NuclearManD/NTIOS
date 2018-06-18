;  Origionally from some old OS design I made.
; Then became MinOS
; Kernel reused in NTIOS 0.1
; Kernel moved to C port of OS to speed up OS functions using assembly
; Copyright Dylan Brophy 2017

.module BOOT
.globl	_osstart
.globl	gsinit
.area	HOME
_main::
vectors::
	jp os_start ; 0000 (reboot)
	jp ostream  ; 0003
	jp 0        ; 0006
	jp 0        ; 0009
	jp 0;delete   000C
	jp strcomp  ; 000F
	jp 0        ; 0012
	jp 0000     ; 0015
	jp 0000;endpgm   ; 0018
	
	jp 0000     ; 001B
	jp 0000     ; 001E
	jp 0000     ; 0021
	jp 0000     ; 0024
	nop
	jp 0000     ; 0028
	jp 0000     ; 002B
	jp 0000     ; 002E
	jp 0000     ; 0031
	jp 0000     ; 0034
nop             ; 0037
int38::         ; 0038, Z80 interrupt mode 1 vector
	push hl
	push af
	push de
	push bc
	push ix
	push iy
	jp 55 ; lol
	pop iy
	pop ix
	pop bc
	pop de
	pop af
	pop hl
	reti
.area _CODE
os_start::
	di
	ld sp, #0xFFFF
	ld hl, #0
	; Hardware (UART) setup if using 18.43MHz clock
	ld a, #0x80 
	out (3), a			; SET DLAB
	ld a, #10			; 115200 baud
	out (0), a
	ld a, #0
	out (1), a        
	ld a, #3
	out (3), a          ; 8-bit serial, RESET DLAB
	ld a, #1
	out (2), a          ; enable FIFOs
	
	ld a, #0
	call uart_send
	
	call gsinit ; start cstdlib
	call _osstart
.hlt:
	halt
	jp .hlt ; main shouldn't return, but if it does, then halt the CPU.

strcomp::
	push de
	push hl
.strcomp_l: 
    ld a,(de) 
    cp (hl) 
    jp nz, .strcret    ;nz means they are not equal 
    inc hl 
    inc de 
    or a       ;set the z flag if they're equal
    jp nz, .strcomp_l
.strcret:
	pop hl
	pop de
	jr z, .equal
	ld a, #1
	or a 
	ret
.equal:
	xor a
	ret
	
; int_to_hex - convert HL into hex string in de (allocate your own RAM)
int_to_hex::
	push de
	ex de, hl
	push hl
	ld a, d
	call .c1
	ld (hl), a
	inc hl
	ld a, d
	call .c2
	ld (hl), a
	inc hl
	ld a, e
	call .c1
	ld (hl), a
	inc hl
	ld a, e
	call .c2
	ld (hl), a
	inc hl
	xor a
	ld (hl), a
	pop hl
	pop de
	ret
.c1:
	rra
	rra
	rra
	rra
.c2:
	or #0xF0
	daa
	add a, #0xA0
	adc a, #0x40 ; Ascii hex at this point (0 to F)   
	ret
; len - get string length in bc
strlen::
	push hl
	push de
	push hl
	ld a, #0
	cpir
	pop de
	or a
	sbc hl, de 
	ld b, h
	ld c, l
	ld h, d
	ld l, e
	pop de
	pop hl
	ret
; uart_send - send A to UART
uart_send::
	push af
.s:
	in a, (#5)
	and a, #32
	jr z, .s
	pop af
	out (#0), a
	ret
; ostream - hl points to data to send
ostream::
	push af
	push hl
ostream_loop:
	ld a, (hl)
	or a
	jp z, ostream_done
	call uart_send
	inc hl
	jr ostream_loop
ostream_done:
	pop hl
	pop af
	ret

; print - hl points to string to print on screen

uart_print::
	call ostream
	ld a, #13
	call uart_send
	ret
; input_uart - receive string from UART and store it in HL
uart_input::
	push hl
.lopen:
	in a, (#5)
	bit #0, a
	jp z, .lopen
	in a, (#0)
	cp #8
	jp z, .delete
	out (#0), a
	cp #13
	jp z, .done
	ld (hl), a
	inc hl
	jp .lopen
.delete:
	dec hl
	ld a, #8
	call uart_send
	ld a, #32
	call uart_send
	ld a, #8
	call uart_send
	jr .lopen
.done:
	xor a
	ld (hl), a
	pop hl
	ret
	