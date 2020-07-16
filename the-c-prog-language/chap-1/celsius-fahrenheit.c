#include <stdio.h>

/*For fahr 0, 20, ..., 300. 
Print Celsius to Fahrenheit conversion table*/

int main()
{
    float fahr, celsius;
    int step, lower, upper;

    lower = 0;
    upper = 300;
    step = 20;

    printf("Celsius Fahreneheit\n");

    while (celsius <= upper) {
        fahr = celsius * (9.0/5.0) + 32;
        printf("%7.0f %11.1f\n", celsius, fahr);
        celsius = celsius + step;
    }
}