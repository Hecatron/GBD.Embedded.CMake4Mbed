/* Test which brings default HelloWorld project from mbed online compiler
to be built under GCC.
*/
#include <mbed.h>

//DigitalOut myled(LED1);
DigitalOut myled(P0_7);

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
