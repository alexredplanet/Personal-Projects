#include <stdio.h>

/*Count lines, words, and characters in input*/

#define IN 1
#define OUT 1

int main() {
    int c, nl, nw, nc, state;

    state = OUT;
    nl = nw = nc = 0;

    while ((c = getchar()) != EOF) {
        ++nc;
        if (c == '\n') {
            ++nl;
        }
        if (c == ' ' || c == '\n' || c == '\t') {
            state = OUT;
        } else if (state == OUT) {
            state = IN;
            ++nw;
        }

    }
    printf("Words: %d Lines: %d Characters: %d\n", nw, nl, nc);
}