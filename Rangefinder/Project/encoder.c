#include <avr/io.h>
#include <util/delay.h>
#include <stdio.h>
#include <avr/interrupt.h>
#include "rangefinder.h"
#include "encoder.h"


volatile unsigned char a, b;
volatile unsigned char new_state, old_state;
 
void encoder_init() {

	DDRC &= ((1 << 1) | (1 << 5)); //initialize encoder
	PCMSK1 |= (1 << PCINT9) | (1 << PCINT13);
	PORTC |= ((1 << 1) | (1 << 5));
	
	
	//encoder initialization
	a = PINC & (1 << 5), b = PINC & (1 << 1);

    if (!b && !a)
    old_state = 0;
    else if (!b && a)
    old_state = 1;
    else if (b && !a)
    old_state = 2;
    else
    old_state = 3;
    new_state = old_state;
}

ISR(PCINT1_vect) { //rotary encoder interrupt 
	
    a = PINC & (1 << 5), b = PINC & (1 << 1);   
    if (old_state == 0) {
        if(a) { 
            new_state = 1;
            count++;  
        }
        else if(b) {
            new_state = 2;
            count--;  
        }
    }
    else if (old_state == 1) {
        if (!a) { 
            new_state = 0; 
            count--; 
        }
        if(b) { 
            new_state = 3; 
            count++; 
        }
    }
    else if (old_state == 2) {
        if(a) { 
            new_state = 3; 
            count--; 
        }
        if(!b) { 
            new_state = 0; 
            count++; 
        }
    }
    else {   // old_state = 3
        if(!a){ 
            new_state = 2; 
            count++; 
        }
        if(!b) { 
            new_state = 1; 
            count--; 
        }
    } 

    if(count >= 400) {
        count = 1; 
    } else if(count <= 1) {
        count = 400; 
    }

    if(old_state != new_state) { //checks if state changed and updates the flag 
        change = 1; 
        old_state = new_state; 
    }
}