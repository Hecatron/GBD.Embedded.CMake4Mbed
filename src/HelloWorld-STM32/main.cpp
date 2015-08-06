/* Test which brings default HelloWorld project from mbed online compiler
to be built under GCC.
*/
#include <mbed.h>

// http://uk.farnell.com/olimex/olimexino-stm32/demo-board-olimexino-stm32/dp/2061325?ost=2061325&mckv=xWeIUYdG&CMP=KNC-GUK-FUK-GEN-SHOPPING-OLIMEX&CAGPSPN=pla&gclid=CPO5z4SXkscCFWnLtAoda_QLGw&CAWELAID=120173390000350726&gross_price=true
// STM32F103RBT6
// TARGET_STM\TARGET_STM32F1\TARGET_NUCLEO_F103RB
// NUCLEO_F103RB-device.mk
// https://www.olimex.com/Products/Duino/STM32/OLIMEXINO-STM32/resources/OLIMEXINO-STM32_Rev.A-schematic.pdf

//DigitalOut myled(LED1);
DigitalOut myled(PA_1);

int main()
{
	while (1)
	{
		myled = 1;
		wait(1);
		myled = 0;
		wait(1);
	}
}
