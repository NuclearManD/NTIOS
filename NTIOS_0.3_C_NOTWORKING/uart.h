#ifndef UART_H
#define UART_H
void uart_setup();
void uart_println(char* a);
void uart_input(char* buf);
#include "uart.c"
#endif
