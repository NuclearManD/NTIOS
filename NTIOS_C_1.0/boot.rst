ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;  Origionally from some old OS design I made.
                              2 ; Then became MinOS
                              3 ; Kernel reused in NTIOS 0.1
                              4 ; Kernel moved to C port of OS to speed up OS functions using assembly
                              5 ; Copyright Dylan Brophy 2017
                              6 
                              7 .module BOOT
                              8 .globl	_osstart
                              9 .globl	gsinit
                             10 .area	HOME
   0000                      11 _main::
   0000                      12 vectors::
   0000 C3 50 00      [10]   13 	jp os_start ; 0000 (reboot)
   0003 C3 D8 00      [10]   14 	jp ostream  ; 0003
   0006 C3 00 00      [10]   15 	jp 0        ; 0006
   0009 C3 00 00      [10]   16 	jp 0        ; 0009
   000C C3 00 00      [10]   17 	jp 0;delete   000C
   000F C3 7A 00      [10]   18 	jp strcomp  ; 000F
   0012 C3 00 00      [10]   19 	jp 0        ; 0012
   0015 C3 00 00      [10]   20 	jp 0000     ; 0015
   0018 C3 00 00      [10]   21 	jp 0000;endpgm   ; 0018
                             22 	
   001B C3 00 00      [10]   23 	jp 0000     ; 001B
   001E C3 00 00      [10]   24 	jp 0000     ; 001E
   0021 C3 00 00      [10]   25 	jp 0000     ; 0021
   0024 C3 00 00      [10]   26 	jp 0000     ; 0024
   0027 00            [ 4]   27 	nop
   0028 C3 00 00      [10]   28 	jp 0000     ; 0028
   002B C3 00 00      [10]   29 	jp 0000     ; 002B
   002E C3 00 00      [10]   30 	jp 0000     ; 002E
   0031 C3 00 00      [10]   31 	jp 0000     ; 0031
   0034 C3 00 00      [10]   32 	jp 0000     ; 0034
   0037 00            [ 4]   33 nop             ; 0037
   0038                      34 int38::         ; 0038, Z80 interrupt mode 1 vector
   0038 E5            [11]   35 	push hl
   0039 F5            [11]   36 	push af
   003A D5            [11]   37 	push de
   003B C5            [11]   38 	push bc
   003C DD E5         [15]   39 	push ix
   003E FD E5         [15]   40 	push iy
   0040 C3 37 00      [10]   41 	jp 55 ; lol
   0043 FD E1         [14]   42 	pop iy
   0045 DD E1         [14]   43 	pop ix
   0047 C1            [10]   44 	pop bc
   0048 D1            [10]   45 	pop de
   0049 F1            [10]   46 	pop af
   004A E1            [10]   47 	pop hl
   004B ED 4D         [14]   48 	reti
                             49 .area _CODE
   0050                      50 os_start::
   0050 F3            [ 4]   51 	di
   0051 31 FF FF      [10]   52 	ld sp, #0xFFFF
   0054 21 00 00      [10]   53 	ld hl, #0
                             54 	; Hardware (UART) setup if using 18.43MHz clock
   0057 3E 80         [ 7]   55 	ld a, #0x80 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



   0059 D3 03         [11]   56 	out (3), a			; SET DLAB
   005B 3E 0A         [ 7]   57 	ld a, #10			; 115200 baud
   005D D3 00         [11]   58 	out (0), a
   005F 3E 00         [ 7]   59 	ld a, #0
   0061 D3 01         [11]   60 	out (1), a        
   0063 3E 03         [ 7]   61 	ld a, #3
   0065 D3 03         [11]   62 	out (3), a          ; 8-bit serial, RESET DLAB
   0067 3E 01         [ 7]   63 	ld a, #1
   0069 D3 02         [11]   64 	out (2), a          ; enable FIFOs
                             65 	
   006B 3E 00         [ 7]   66 	ld a, #0
   006D CD CD 00      [17]   67 	call uart_send
                             68 	
   0070 CD 22 01      [17]   69 	call gsinit ; start cstdlib
   0073 CD AE 01      [17]   70 	call _osstart
   0076                      71 .hlt:
   0076 76            [ 4]   72 	halt
   0077 C3 76 00      [10]   73 	jp .hlt ; main shouldn't return, but if it does, then halt the CPU.
                             74 
   007A                      75 strcomp::
   007A D5            [11]   76 	push de
   007B E5            [11]   77 	push hl
   007C                      78 .strcomp_l: 
   007C 1A            [ 7]   79     ld a,(de) 
   007D BE            [ 7]   80     cp (hl) 
   007E C2 87 00      [10]   81     jp nz, .strcret    ;nz means they are not equal 
   0081 23            [ 6]   82     inc hl 
   0082 13            [ 6]   83     inc de 
   0083 B7            [ 4]   84     or a       ;set the z flag if they're equal
   0084 C2 7C 00      [10]   85     jp nz, .strcomp_l
   0087                      86 .strcret:
   0087 E1            [10]   87 	pop hl
   0088 D1            [10]   88 	pop de
   0089 28 04         [12]   89 	jr z, .equal
   008B 3E 01         [ 7]   90 	ld a, #1
   008D B7            [ 4]   91 	or a 
   008E C9            [10]   92 	ret
   008F                      93 .equal:
   008F AF            [ 4]   94 	xor a
   0090 C9            [10]   95 	ret
                             96 	
                             97 ; int_to_hex - convert HL into hex string in de (allocate your own RAM)
   0091                      98 int_to_hex::
   0091 D5            [11]   99 	push de
   0092 EB            [ 4]  100 	ex de, hl
   0093 E5            [11]  101 	push hl
   0094 7A            [ 4]  102 	ld a, d
   0095 CD B1 00      [17]  103 	call .c1
   0098 77            [ 7]  104 	ld (hl), a
   0099 23            [ 6]  105 	inc hl
   009A 7A            [ 4]  106 	ld a, d
   009B CD B5 00      [17]  107 	call .c2
   009E 77            [ 7]  108 	ld (hl), a
   009F 23            [ 6]  109 	inc hl
   00A0 7B            [ 4]  110 	ld a, e
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



   00A1 CD B1 00      [17]  111 	call .c1
   00A4 77            [ 7]  112 	ld (hl), a
   00A5 23            [ 6]  113 	inc hl
   00A6 7B            [ 4]  114 	ld a, e
   00A7 CD B5 00      [17]  115 	call .c2
   00AA 77            [ 7]  116 	ld (hl), a
   00AB 23            [ 6]  117 	inc hl
   00AC AF            [ 4]  118 	xor a
   00AD 77            [ 7]  119 	ld (hl), a
   00AE E1            [10]  120 	pop hl
   00AF D1            [10]  121 	pop de
   00B0 C9            [10]  122 	ret
   00B1                     123 .c1:
   00B1 1F            [ 4]  124 	rra
   00B2 1F            [ 4]  125 	rra
   00B3 1F            [ 4]  126 	rra
   00B4 1F            [ 4]  127 	rra
   00B5                     128 .c2:
   00B5 F6 F0         [ 7]  129 	or #0xF0
   00B7 27            [ 4]  130 	daa
   00B8 C6 A0         [ 7]  131 	add a, #0xA0
   00BA CE 40         [ 7]  132 	adc a, #0x40 ; Ascii hex at this point (0 to F)   
   00BC C9            [10]  133 	ret
                            134 ; len - get string length in bc
   00BD                     135 strlen::
   00BD D5            [11]  136 	push de
   00BE E5            [11]  137 	push hl
   00BF 3E 00         [ 7]  138 	ld a, #0
   00C1 ED B1         [21]  139 	cpir
   00C3 D1            [10]  140 	pop de
   00C4 B7            [ 4]  141 	or a
   00C5 ED 52         [15]  142 	sbc hl, de 
   00C7 44            [ 4]  143 	ld b, h
   00C8 4D            [ 4]  144 	ld c, l
   00C9 62            [ 4]  145 	ld h, d
   00CA 6B            [ 4]  146 	ld l, e
   00CB D1            [10]  147 	pop de
   00CC C9            [10]  148 	ret
                            149 ; uart_send - send A to UART
   00CD                     150 uart_send::
   00CD F5            [11]  151 	push af
   00CE                     152 .s:
   00CE DB 05         [11]  153 	in a, (#5)
   00D0 E6 20         [ 7]  154 	and a, #32
   00D2 28 FA         [12]  155 	jr z, .s
   00D4 F1            [10]  156 	pop af
   00D5 D3 00         [11]  157 	out (#0), a
   00D7 C9            [10]  158 	ret
                            159 ; ostream - hl points to data to send
   00D8                     160 ostream::
   00D8 F5            [11]  161 	push af
   00D9 E5            [11]  162 	push hl
   00DA                     163 ostream_loop:
   00DA 7E            [ 7]  164 	ld a, (hl)
   00DB B7            [ 4]  165 	or a
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 4.
Hexadecimal [16-Bits]



   00DC CA E5 00      [10]  166 	jp z, ostream_done
   00DF CD CD 00      [17]  167 	call uart_send
   00E2 23            [ 6]  168 	inc hl
   00E3 18 F5         [12]  169 	jr ostream_loop
   00E5                     170 ostream_done:
   00E5 E1            [10]  171 	pop hl
   00E6 F1            [10]  172 	pop af
   00E7 C9            [10]  173 	ret
                            174 
                            175 ; print - hl points to string to print on screen
                            176 
   00E8                     177 uart_print::
   00E8 CD D8 00      [17]  178 	call ostream
   00EB 3E 0D         [ 7]  179 	ld a, #13
   00ED CD CD 00      [17]  180 	call uart_send
   00F0 C9            [10]  181 	ret
                            182 ; input_uart - receive string from UART and store it in HL
   00F1                     183 uart_input::
   00F1 E5            [11]  184 	push hl
   00F2                     185 .lopen:
   00F2 DB 05         [11]  186 	in a, (#5)
   00F4 CB 47         [ 8]  187 	bit #0, a
   00F6 CA F2 00      [10]  188 	jp z, .lopen
   00F9 DB 00         [11]  189 	in a, (#0)
   00FB FE 08         [ 7]  190 	cp #8
   00FD CA 0C 01      [10]  191 	jp z, .delete
   0100 D3 00         [11]  192 	out (#0), a
   0102 FE 0D         [ 7]  193 	cp #13
   0104 CA 1E 01      [10]  194 	jp z, .done
   0107 77            [ 7]  195 	ld (hl), a
   0108 23            [ 6]  196 	inc hl
   0109 C3 F2 00      [10]  197 	jp .lopen
   010C                     198 .delete:
   010C 2B            [ 6]  199 	dec hl
   010D 3E 08         [ 7]  200 	ld a, #8
   010F CD CD 00      [17]  201 	call uart_send
   0112 3E 20         [ 7]  202 	ld a, #32
   0114 CD CD 00      [17]  203 	call uart_send
   0117 3E 08         [ 7]  204 	ld a, #8
   0119 CD CD 00      [17]  205 	call uart_send
   011C 18 D4         [12]  206 	jr .lopen
   011E                     207 .done:
   011E AF            [ 4]  208 	xor a
   011F 77            [ 7]  209 	ld (hl), a
   0120 E1            [10]  210 	pop hl
   0121 C9            [10]  211 	ret
                            212 	
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 5.
Hexadecimal [16-Bits]

Symbol Table

    .__.$$$.=  2710 L   |     .__.ABS.=  0000 G   |     .__.CPU.=  0000 L
    .__.H$L.=  0000 L   |   0 .c1        0061 R   |   0 .c2        0065 R
  0 .delete    00BC R   |   0 .done      00CE R   |   0 .equal     003F R
  0 .hlt       0026 R   |   0 .lopen     00A2 R   |   0 .s         007E R
  0 .strcomp   002C R   |   0 .strcret   0037 R   |   1 _main      0000 GR
    _osstart   **** GX  |     gsinit     **** GX  |   1 int38      0038 GR
  0 int_to_h   0041 GR  |   0 os_start   0000 GR  |   0 ostream    0088 GR
  0 ostream_   0095 R   |   0 ostream_   008A R   |   0 strcomp    002A GR
  0 strlen     006D GR  |   0 uart_inp   00A1 GR  |   0 uart_pri   0098 GR
  0 uart_sen   007D GR  |   1 vectors    0000 GR

ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 6.
Hexadecimal [16-Bits]

Area Table

   0 _CODE      size   D2   flags    0
   1 HOME       size   4D   flags    0

