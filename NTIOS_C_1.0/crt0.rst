ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;--------------------------------------------------------------------------
                              2 ;  crt0.s - Generic crt0.s for a Z80
                              3 ;
                              4 ;  Copyright (C) 2000, Michael Hope
                              5 ;
                              6 ;  This library is free software; you can redistribute it and/or modify it
                              7 ;  under the terms of the GNU General Public License as published by the
                              8 ;  Free Software Foundation; either version 2, or (at your option) any
                              9 ;  later version.
                             10 ;
                             11 ;  This library is distributed in the hope that it will be useful,
                             12 ;  but WITHOUT ANY WARRANTY; without even the implied warranty of
                             13 ;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
                             14 ;  GNU General Public License for more details.
                             15 ;
                             16 ;  You should have received a copy of the GNU General Public License 
                             17 ;  along with this library; see the file COPYING. If not, write to the
                             18 ;  Free Software Foundation, 51 Franklin Street, Fifth Floor, Boston,
                             19 ;   MA 02110-1301, USA.
                             20 ;
                             21 ;  As a special exception, if you link this library with other files,
                             22 ;  some of which are compiled with SDCC, to produce an executable,
                             23 ;  this library does not by itself cause the resulting executable to
                             24 ;  be covered by the GNU General Public License. This exception does
                             25 ;  not however invalidate any other reasons why the executable file
                             26 ;   might be covered by the GNU General Public License.
                             27 ;--------------------------------------------------------------------------
                             28 
                             29 	.module crt0
                             30 	.globl	l__INITIALIZER
                             31 	.globl	s__INITIALIZED
                             32 	.globl	s__INITIALIZER
                             33 
                             34 	.area   _CODE
   0122                      35 gsinit::
   0122 01 00 00      [10]   36 	ld	bc, #l__INITIALIZER
   0125 78            [ 4]   37 	ld	a, b
   0126 B1            [ 4]   38 	or	a, c
   0127 28 08         [12]   39 	jr	Z, gsinit_next
   0129 11 52 00      [10]   40 	ld	de, #s__INITIALIZED
   012C 21 52 00      [10]   41 	ld	hl, #s__INITIALIZER
   012F ED B0         [21]   42 	ldir
   0131                      43 gsinit_next:
                             44 
                             45 	.area   _CODE
   0131 C9            [10]   46 	ret
                             47 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]

Symbol Table

    .__.$$$.=  2710 L   |     .__.ABS.=  0000 G   |     .__.CPU.=  0000 L
    .__.H$L.=  0000 L   |   0 gsinit     0000 GR  |   0 gsinit_n   000F R
    l__INITI   **** GX  |     s__INITI   **** GX  |     s__INITI   **** GX

ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]

Area Table

   0 _CODE      size   10   flags    0

