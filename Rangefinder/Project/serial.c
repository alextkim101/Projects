#include "serial.h"
#include "rangefinder.h"
#include <avr/io.h>
#include <util/delay.h>
#include <stdio.h>
#include <avr/interrupt.h>

//prototypes 
void serial_init(unsigned short ubrr_value); 
void serial_txchar(char ch); 
void serial_stringout(char *s); 
void send(int distance); 


volatile int rxindex = 0;

void serial_init(unsigned short ubrr_value) {
    // Set up USART0 registers
    UCSR0B |= (1 << TXEN0 | 1 << RXEN0);  // Enable RX and TX
    UCSR0C = (3 << UCSZ00); 
    // Enable tri-state
    DDRC |= (1 << 4);
    PORTC &= ~(1 << 4);
    
    UBRR0 = ubrr_value; // Set baud rate

    UCSR0B |= (1 << RXCIE0);    // Enable receiver interrupts

    
}

void serial_txchar(char ch) {
    while ((UCSR0A & (1<<UDRE0)) == 0);
    UDR0 = ch;
}

void serial_stringout(char *s) {
    // Call serial_txchar in loop to send a string
    int i = 0;
    char ch = s[i];
    while(ch != '$'){
        serial_txchar(ch);
        i++;
        ch = s[i];
    }
    //sends the last '$' char 
    serial_txchar(ch);
}

void send(int distance) {
    char buf[6]; 
    snprintf(buf, 6, "@%d$", distance);
    serial_stringout(buf);
}


ISR(USART_RX_vect) {//interupt for rx 
    char ch;
    // Get the received character
    ch = UDR0;
    
    if(ch == '@'){
        rxindex = 0;
        begin = 1; 
        valid = 0; 
        //resets array to null
        int i = 0;
        for(i = 0; i < 4; i++) {
            rxRaw[i] = '\0';
        }
    } else if(begin) {
        if(rxindex == 4) {
            begin = 0;
        } else {
            if(ch == '$') {
                if(rxindex != 0) {
                    valid = 1;
                }
            } else if(ch >= '0' && ch <= '9') {
                rxRaw[rxindex] = ch;
                rxindex++;
            } else {
                begin = 0;
            }
        }
    }
}
