#include <stdio.h>

/*Replace tabs with \t, backspace with \b
 and backslash with \\*/

int main()
{
    int c;

    while((c=getchar()) != EOF) {
        if (c == '\t') {
            printf("\\t");
            while((c=getchar()) == '\t'){
                printf("\\t");
            }
        } 
        if (c == '\b') {
            printf("\\b");
            while((c=getchar()) == '\b'){
                printf("\\b");
            }
        } 
        if (c == '\\') {
            printf("\\");
            while((c=getchar()) == '\\'){
                printf("\\");
            }
        }
        putchar(c);
    }
}