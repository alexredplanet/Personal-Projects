#include <stdio.h>

/*Prints each word of input on a newline,
accounts for multiple spaces, tabs, newlines*/

#define IN 1
#define OUT 0

int main() {
    int c, c_prev;

    c_prev = OUT;

    while ((c = getchar()) != EOF) {
        if ((c == ' ' || c == '\n' || c == '\t') && c_prev == IN) {
            c_prev = OUT;
            printf("\n");
        } else if (c_prev == OUT && (c != ' ' && c != '\n' && c != '\t')) {
            c_prev = IN;
        }
        if (c_prev == IN) {
            putchar(c);
        }
    }
}