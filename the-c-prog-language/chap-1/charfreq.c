/*Print a histogram of the frequency of each character
in a given input*/

/* 
Example Input:
This program prints a frequency of all characters given in input
It includes tabs, spaces, and newlines.
Here are two tabs: 
Enjoy!

Example OutPut
\t: **
\n: ****
  : ******************
 !: *
 ,: **
 .: *
 :: *
 E: *
 H: *
 I: *
 T: *
 a: **********
 b: **
 c: *****
 d: **
 e: ***********
 f: **
 g: **
 h: **
 i: *******
 j: *
 l: ****
 m: *
 n: **********
 o: ****
 p: ****
 q: *
 r: ********
 s: *********
 t: *******
 u: ***
 v: *
 w: **
 y: **
*/
#include <stdio.h>

#define num_chars 128 //There are 128 different ascii characters

int main() {

    int c;
    int char_freqs[num_chars]; 

    //Initiliase char_freqs to 0
    for (int i = 0; i < 128; ++i)
        char_freqs[i] = 0;

    //Tally every char
    while ((c=getchar()) != EOF)
    {
        ++char_freqs[c];
    }

    //Print a horizontal histogram of char count
    for (int j = 0; j < num_chars; ++j)
    {
        if (char_freqs[j] > 0)
        {
            if (j == 10)
            {
                printf("\\n: ");
            }
            else if (j == 9)
            {
                printf("\\t: ");
            }
            else
            {
            printf("%2c: ", j);
            }
            for (int y = 0; y < char_freqs[j]; ++y)
            {
                printf("*");
            }
            printf("\n");
        }
    }
}