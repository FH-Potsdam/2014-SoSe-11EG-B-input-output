#define F_CPU 1200000UL

#define Servos	2

#define SlowSpeedValue	500
#define FastSpeedValue	200

#define BackIsPressed	(PINB & (1<<PB3))
#define FrontIsPressed	(PINB & (1<<PB4))

#define Servo_on		(PORTB |= (1<<PB1))
#define Servo_off		(PORTB &= ~(1<<PB1)) 



#include <avr/io.h>
#include <avr/delay.h>


int main(void)
{
	DDRB=0b11100111;
	PORTB=0;
	
    while(1)
    {
		//Welche Richtung
        if (BackIsPressed)
        {
			for (uint16_t time=0; time<20; time++)
			{
				//swipe forward
				Servo_on;
				_delay_us(1400);
				Servo_off;
				_delay_ms(20);
			}
			
			for (uint16_t time=0; time<20; time++)
			{
				//swipe backyard
				Servo_on;
				_delay_us(1250);
				Servo_off;
				_delay_ms(20);
			}
        } 
        else if (FrontIsPressed)
        {
			for (uint16_t time=0; time<13; time++)
			{
				//swipe forward
				Servo_on;
				_delay_us(1400);
				Servo_off;
				_delay_ms(50);
			}
			
			for (uint16_t time=0; time<13; time++)
			{
				//swipe backyard
				Servo_on;
				_delay_us(1250);
				Servo_off;
				_delay_ms(50);
			}
        }
    }
}