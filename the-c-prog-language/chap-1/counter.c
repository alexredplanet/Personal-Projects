#include <stdio.h>

/*Count the number of blanks, tabs, and newlines given as input*/

int main()
{
    long b, t, nl;
    int c;

    b = t = nl = 0;

    while((c=getchar()) != EOF) {
        if (c == '\n')
            ++nl;
        if (c == '\t')
            ++t;
        if (c == ' ')
            ++b;   
    }

    printf("Newlines: %ld\n", nl);
    printf("Tabs: %ld\n", t);
    printf("Blanks: %ld\n", b);
}