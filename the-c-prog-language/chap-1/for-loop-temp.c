#include <stdio.h>

/* Print a fahrenheit to celcius table*/

#define LOWER 0    /*Lower temperature*/
#define UPPER 300  /*Upper temperature*/
#define STEP 20    /*Step (in fahrenheit) between temperatures*/

int main()
{
    int fahr;
    
    for (fahr = UPPER; fahr >= LOWER; fahr = fahr - STEP)
        printf("%3d, %6.1f\n", fahr, (5.0/9.0)*(fahr-32));
}