#include <avr/io.h>
#include <util/delay.h>
#include <stdio.h>
#include <avr/interrupt.h>
#include <avr/eeprom.h>
#include "lcd.h"
#include "rangefinder.h"
#include "encoder.h"
#include "serial.h"

#define FOSC 16000000           // Clock frequency
#define BAUD 9600               // Baud rate used
#define MYUBRR FOSC/16/BAUD-1   // Value for UBRR0 register

// Serial communications functions and variables
void acquire(); 
char debounce(char bit); 
char checkInput(char bit);  
void play_note();

//main
int distance;
unsigned char state = 0; 
volatile int count_value; 
//for echo and trig 
volatile int flag = 0;
volatile int OB = 0;
// for rx and tx 
volatile char rxRaw[4]; //array for received messages, 
volatile int begin = 0;
volatile int valid = 0;
//for the encoder  
volatile int change = 0; //indicatees that count(the mindistance) has been updates 
volatile int count = 1; //count is minimum distance set by the rotary encoder
//for the buzzer 
volatile int alarm = 330;

void init_timer1(unsigned short m) {

    TCCR1B |= (1 << WGM12);
    TIMSK1 |= (1 << OCIE1A);
    OCR1A = m;
}

int main() {
	lcd_init();  //initialize LCD
	encoder_init(); 
	init_timer1(46400); 
	serial_init(MYUBRR);

	PORTB |= (1 << 3) | ( 1 << 4); //init buttons
	DDRC |= (1 << 2) | (1 << 3); //init leds as outputs
	DDRB |= (1 << 5); //initialize buzzer as output
	
	lcd_writecommand(1);
	
	//interrupt initialization
	PCICR |= (1 << PCIE1) | (1 << PCIE2);
	PCMSK2 |= (1 << PCINT18);
		
	//Buzzer interupts
	TCCR0B |= (1 << CS02);
	OCR0A = 119;
	TIMSK0 |= (1 << OCIE0A);
	sei();
	
	//reads from ee prom 
	count = eeprom_read_word((void *) 300); 
	//incase value in eeprom is unusable, 
    if(count < 1 || count > 400) {
        count = 1; 
    }
	//displays minimum distance when first turned on 
	char minDis[10];
	lcd_moveto(0, 8);
	snprintf(minDis, 10, "MIN:%d", count);
	lcd_stringout(minDis);
	
	while(1) {
		
		if(change == 1){ // Did state of rotary encoder change? (minDis changes)
			change = 0;
			//updats value for eeprom 
			eeprom_update_word (( void *) 300 , count);

			snprintf(minDis, 10, "%d", count);

			lcd_moveto(0, 12); 
			lcd_stringout("        ");
			lcd_moveto(0, 12);
			lcd_stringout(minDis);
		}

		if(state == 0) { 
				lcd_moveto(0, 0);
				lcd_stringout("Single");
			if(debounce(3) == 0) { 
				state = 1; 
			} else if(debounce(4) == 0) { 
				acquire(); 
			}
		} else if(state == 1) { 
				if(debounce(3) == 0) { 
					state = 0; 
				} else if(debounce(4) == 0) { 
					state = 0; 
				}
				lcd_moveto(0, 0);
				lcd_stringout("Repeat");
				acquire(); 
		}
		//only if both flag is activiated, lcd displays received distance 
		if(valid == 1 && begin == 1){
			valid = 0;
			begin = 0;

			int rxDistance;
			sscanf(rxRaw, "%d", &rxDistance);

			int cm = rxDistance/10;
			int mm = rxDistance%10;
			char rxConverted[8];
			snprintf(rxConverted, 8, "%3d.%1dcm", cm, mm);

			lcd_moveto(1, 8);
			lcd_stringout("         ");

			lcd_moveto(1, 8);
			lcd_stringout(rxConverted);

			//LED 
			if(rxDistance < distance) {
				PORTC |= (1 << 3);
				PORTC &= ~(1 << 2);
			} else if (rxDistance > distance) {
				PORTC &= ~(1 << 3);
				PORTC |= (1 << 2);
			} else {
				PORTC &= ~(1 << 2);
				PORTC &= ~(1 << 3);
			}
			//only plays buzzer in single mode 
			if(state == 0) { 
				if(rxDistance <= count*10) {
					play_note();
				}
			}
		}
	}
}

void acquire() { 
	//generates 10microsec pulse 
	PORTD |= (1 << 2); //set trigger pin to 1
	_delay_us(10);
	PORTD &= ~(1 << 2); //set trigger to 0 
	//PORTB &= ~(1 << 4); 

	//checks for outofrange
	if(OB == 1) {
		//reverts the flag 
		OB = 0;
		lcd_moveto(1, 0);
		lcd_stringout("            ");
		lcd_moveto(1, 0);
		lcd_stringout("out of range");

	} else if(flag == 1){ 	//checks echo 
		//resets flag 
		flag = 0;
		//in mm 
		distance = (count_value/116)*10; 
		//display only when reading is greater 2cm since that's the min distance based on the info sheet 
		if(distance >= 20) {
			int cm = distance/10;
			int mm = distance%10;
			char display[6];
			snprintf(display, 6, "%d.%d", cm, mm);

			lcd_moveto(1, 0);
			lcd_stringout("            ");

			lcd_moveto(1, 0);
			lcd_stringout(display);	
			//delay to make it more readable in repeat mode 
			if(state == 1) { 
				_delay_ms(200);
			}
		}
		send(distance);
	} 
}
//debounces buttons 
char debounce(char bit) {

    if(checkInput(bit) == 0) {
        _delay_ms(5); 
         while(checkInput(bit) == 0) {
             _delay_ms(5); 
        }
         return 0; 
    } else {
        return(1); 
    }
}
//checks for pressed buttons
char checkInput(char bit) {

    if ((PINB & (1 << bit)) != 0)
        return(1);
    else
        return(0);
}

void play_note() {
	TCCR0B |= (1 << CS02);
}

ISR(TIMER1_COMPA_vect) {

	//turn of timer 
	TCCR1B &= ~(1 << CS11);
	//update flag  
	OB = 1;
}

ISR(PCINT2_vect) {//pc interrupt for rangefinder echo

	if((PIND & (1 << 3)) != 0){ //if echo is 1 start timer
		TCNT1 = 0; //reset counter
		TCCR1B |= (1 << CS11);
		PORTD &= ~(1 << 3); 
	}
	//for some reason this keeps the count_value consistant 
	if(TCNT1 > 100){
		//if echo = 0, stop timer. 
		if((PIND & (1 << 3)) == 0){  
			TCCR1B &= ~(1 << CS11);
			count_value = TCNT1;
			flag = 1;
			PORTD |= (1 << 3); 
		}
	}
}

ISR(TIMER0_COMPA_vect) { //interrupt for alarm 
	if(alarm == 0) {
		TCCR0B &= ~(1 << CS02);
	} else {
		if(alarm%2 == 0) {
			PORTB |= (1 << 5);
		} else {
			PORTB &= ~(1 << 5);
		}
		alarm--;
	}
}


