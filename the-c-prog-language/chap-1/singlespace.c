#include <stdio.h>

/*Replace one or more spaces given in input with a single space*/

int main()
{
    int c;

    while((c=getchar()) != EOF) {
        if (c == ' ') {
            while((c=getchar()) == ' '){}
            putchar(' ');
        } 
        putchar(c);
    }
}