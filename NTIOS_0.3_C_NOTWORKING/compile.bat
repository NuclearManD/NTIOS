@echo off
:A
zcc +raw main.c -o ntios.bin
pause
goto :A