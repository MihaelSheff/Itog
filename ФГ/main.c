unsigned int interrupt_counter;
unsigned int selector;
unsigned int selector_counter;
unsigned short pulse_counter;
bit work;

void interrupt(){
	if (INTCON.T0IF == 1)
	{
		interrupt_counter ++;
		INTCON.T0IF = 0;
	}
	if (INTCON.INTF == 1)
	{
		if (work == 0)
		{
			interrupt_counter = 0;
			work = 1;
			if (selector_counter == 0)
				selector_counter = 1;
			selector = selector_counter;
			pulse_counter = 1;
		}
		else
		{
			work = 0;
			selector = 0;
			if (selector_counter == 0)
				selector_counter = 1;
			if (selector_counter == 1024)
				selector_counter = 0;
			if (selector_counter != 1024)
				selector_counter = selector_counter*2;
			if (pulse_counter == 10)
			{
				pulse_counter = 0;
			}
			else
				pulse_counter ++;
		}
		INTCON.INTF = 0;
	}
}
void main() {
	//Internal registers
	OPTION_REG.T0CS = 0; //timer0 source is internal
	OPTION_REG.PSA = 0; //prescaler assigned to timer0
	OPTION_REG.PS0 = 0; //prescaler bit 0
	OPTION_REG.PS1 = 0; //prescaler bit 1
	OPTION_REG.PS2 = 0; //prescaler bit 2
	OPTION_REG.INTEDG = 0;
	INTCON.GIE = 1; //global interrupt enabled
	INTCON.T0IE = 1; //timer0 interrupt enabled
	INTCON.INTE = 1; //external interrupt enabled
	
	//Port A
	TRISA = 0;
	PORTA = 0;
	
	//Port B
	TRISB = 0b00000001;
	PORTB = 0;
	
	//Initial values
	TMR0 = 0; //timer0 value
	INTCON.T0IF = 0; //timer0 interrupt flag
	INTCON.INTF = 0; //external interrupt flag
	interrupt_counter = 0;
	selector = 0;
	selector_counter = 0;
	
	//Main cycle
	do{
		if (interrupt_counter == 3906) //occurs every second (15624)
		{
			interrupt_counter = 0;
			if (work == 1)
			{
				if (selector_counter == 0)
					selector_counter = 1;
				if (selector_counter == 1024)
					selector_counter = 0;
				if (selector_counter != 1024)
					selector_counter = selector_counter*2;
				selector = selector_counter;
				if (pulse_counter == 10)
				{
					selector = 0;
					selector_counter = 0;
					pulse_counter = 0;
					work = 0;
				}
				else
					pulse_counter ++;
			}
		}
		PORTA.B3 = selector/1;
		PORTB.B1 = selector/2;
		PORTB.B2 = selector/4;
		PORTB.B3 = selector/8;
		PORTB.B4 = selector/16;
		PORTB.B5 = selector/32;
		PORTB.B6 = selector/64;
		PORTB.B7 = selector/128;
		PORTA.B0 = selector/256;
		PORTA.B1 = selector/512;
	}while(1);
}