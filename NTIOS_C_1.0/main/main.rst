                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.5.0 #9253 (Jun 20 2015) (MINGW64)
                              4 ; This file was generated Sun Jun 17 15:14:40 2018
                              5 ;--------------------------------------------------------
                              6 	.module main
                              7 	.optsdcc -mz80
                              8 	
                              9 ;--------------------------------------------------------
                             10 ; Public variables in this module
                             11 ;--------------------------------------------------------
                             12 	.globl _osstart
                             13 	.globl _print
                             14 	.globl _strcmp
                             15 	.globl __c_retval
                             16 	.globl _qb
                             17 	.globl _qa
                             18 ;--------------------------------------------------------
                             19 ; special function registers
                             20 ;--------------------------------------------------------
                             21 ;--------------------------------------------------------
                             22 ; ram data
                             23 ;--------------------------------------------------------
                             24 	.area _DATA
   004D                      25 _qa::
   004D                      26 	.ds 2
   004F                      27 _qb::
   004F                      28 	.ds 2
   0051                      29 __c_retval::
   0051                      30 	.ds 1
                             31 ;--------------------------------------------------------
                             32 ; ram data
                             33 ;--------------------------------------------------------
                             34 	.area _INITIALIZED
                             35 ;--------------------------------------------------------
                             36 ; absolute external ram data
                             37 ;--------------------------------------------------------
                             38 	.area _DABS (ABS)
                             39 ;--------------------------------------------------------
                             40 ; global & static initialisations
                             41 ;--------------------------------------------------------
                             42 	.area _HOME
                             43 	.area _GSINIT
                             44 	.area _GSFINAL
                             45 	.area _GSINIT
                             46 ;--------------------------------------------------------
                             47 ; Home
                             48 ;--------------------------------------------------------
                             49 	.area _HOME
                             50 	.area _HOME
                             51 ;--------------------------------------------------------
                             52 ; code
                             53 ;--------------------------------------------------------
                             54 	.area _CODE
                             55 ;os.h:7: char strcmp(char* str1, char* str2){
                             56 ;	---------------------------------
                             57 ; Function strcmp
                             58 ; ---------------------------------
   0132                      59 _strcmp::
                             60 ;os.h:8: qa=str1;
   0132 FD 21 02 00   [14]   61 	ld	iy,#2
   0136 FD 39         [15]   62 	add	iy,sp
   0138 FD 7E 00      [19]   63 	ld	a,0 (iy)
   013B FD 21 4D 00   [14]   64 	ld	iy,#_qa
   013F FD 77 00      [19]   65 	ld	0 (iy),a
   0142 FD 21 02 00   [14]   66 	ld	iy,#2
   0146 FD 39         [15]   67 	add	iy,sp
   0148 FD 7E 01      [19]   68 	ld	a,1 (iy)
   014B FD 21 4D 00   [14]   69 	ld	iy,#_qa
   014F FD 77 01      [19]   70 	ld	1 (iy),a
                             71 ;os.h:9: qb=str2;
   0152 FD 21 04 00   [14]   72 	ld	iy,#4
   0156 FD 39         [15]   73 	add	iy,sp
   0158 FD 7E 00      [19]   74 	ld	a,0 (iy)
   015B FD 21 4F 00   [14]   75 	ld	iy,#_qb
   015F FD 77 00      [19]   76 	ld	0 (iy),a
   0162 FD 21 04 00   [14]   77 	ld	iy,#4
   0166 FD 39         [15]   78 	add	iy,sp
   0168 FD 7E 01      [19]   79 	ld	a,1 (iy)
   016B FD 21 4F 00   [14]   80 	ld	iy,#_qb
   016F FD 77 01      [19]   81 	ld	1 (iy),a
                             82 ;os.h:10: __asm__ ("ld hl, (_qa)\nld de, (_qb)\ncall strcomp\nld (__c_retval), a");
   0172 2A 4D 00      [16]   83 	ld hl, (_qa)
   0175 ED 5B 4F 00   [20]   84 	ld de, (_qb)
   0179 CD 7A 00      [17]   85 	call strcomp
   017C 32 51 00      [13]   86 	ld (__c_retval), a
                             87 ;os.h:11: return _c_retval;
   017F FD 21 51 00   [14]   88 	ld	iy,#__c_retval
   0183 FD 6E 00      [19]   89 	ld	l,0 (iy)
   0186 C9            [10]   90 	ret
                             91 ;os.h:13: void print(char* s){
                             92 ;	---------------------------------
                             93 ; Function print
                             94 ; ---------------------------------
   0187                      95 _print::
                             96 ;os.h:14: qa=s;
   0187 FD 21 02 00   [14]   97 	ld	iy,#2
   018B FD 39         [15]   98 	add	iy,sp
   018D FD 7E 00      [19]   99 	ld	a,0 (iy)
   0190 FD 21 4D 00   [14]  100 	ld	iy,#_qa
   0194 FD 77 00      [19]  101 	ld	0 (iy),a
   0197 FD 21 02 00   [14]  102 	ld	iy,#2
   019B FD 39         [15]  103 	add	iy,sp
   019D FD 7E 01      [19]  104 	ld	a,1 (iy)
   01A0 FD 21 4D 00   [14]  105 	ld	iy,#_qa
   01A4 FD 77 01      [19]  106 	ld	1 (iy),a
                            107 ;os.h:15: __asm__ ("ld hl, (_qa)\ncall ostream");
   01A7 2A 4D 00      [16]  108 	ld hl, (_qa)
   01AA CD D8 00      [17]  109 	call ostream
   01AD C9            [10]  110 	ret
                            111 ;main.c:2: void osstart(){
                            112 ;	---------------------------------
                            113 ; Function osstart
                            114 ; ---------------------------------
   01AE                     115 _osstart::
                            116 ;main.c:3: print("Hello World!!");
   01AE 21 B7 01      [10]  117 	ld	hl,#___str_0
   01B1 E5            [11]  118 	push	hl
   01B2 CD 87 01      [17]  119 	call	_print
   01B5 F1            [10]  120 	pop	af
   01B6 C9            [10]  121 	ret
   01B7                     122 ___str_0:
   01B7 48 65 6C 6C 6F 20   123 	.ascii "Hello World!!"
        57 6F 72 6C 64 21
        21
   01C4 00                  124 	.db 0x00
                            125 	.area _CODE
                            126 	.area _INITIALIZER
                            127 	.area _CABS (ABS)
