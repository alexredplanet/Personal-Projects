// Convert celsius to fahrenheit using a function

#include <stdio.h>

int cels_to_fahr(int s, int l, int u);

int main() {
    cels_to_fahr(20, 0, 300);
}

/*cels_to_fahr: convert celsius (c) temp to fahr
between a lower (l) and upper (u) bound, with a step size of s*/
int cels_to_fahr(int s, int l, int u)
{
    float c, f;
    c = l;

    printf("Celsius Fahreneheit\n");
    while (c <= u) {
        f = c * (9.0/5.0) + 32;
        printf("%7.0f %11.1f\n", c, f);
        c = c + s;
    }
    return 0;
}