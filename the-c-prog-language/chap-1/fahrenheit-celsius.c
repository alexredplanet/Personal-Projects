#include <stdio.h>

/*For fahr 0, 20, ..., 300. 
Print Fahrenheit to Celsius conversion table*/

int main()
{
    float fahr, celsius;
    int step, lower, upper;

    lower = 0;
    upper = 300;
    step = 20;

    printf("Fahrenheit  Celsius\n");

    while (fahr <= upper) {
        celsius = (5.0/9.0) * (fahr-32.0);
        printf("%10.0f %8.1f\n", fahr, celsius);
        fahr = fahr + step;
    }
}