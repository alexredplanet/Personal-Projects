/*Prints a histogram of the lengths of words in the given input
Maximum length is 15 but can be altered with MAX_LENGTH definition.*/

/* Example:
Input: 
This is a program that will count the frequency of the length of words in the input.
It does not account for leading or trailing characters, such as . , or '

Output:
 1: ****
 2: ********
 3: *****
 4: *****
 5: **
 6: **
 7: ***
 8: *
 9: *
10: 
11: *
12: 
13: 
14: 
15:           
*/

#include <stdio.h>

#define IN 1
#define OUT 0
#define MAX_LENGTH 15

int main() 
{

    int c, state, length, i, j;
    int word_lengths[MAX_LENGTH];

    // Initialise array values to 0
    for (i = 0; i < MAX_LENGTH; ++i)
    {
        word_lengths[i] = 0;
    }

    //Count the lengths of all words in input
    state = OUT;
    length = 0;
    while((c=getchar()) != EOF) 
    {
        if (c == ' ' || c == '\n' || c == '\t')
        {
            state = OUT;
            if (length == 0) //Accounts for consecutive whitespace
            {
                continue;
            }
            else
            {
                ++word_lengths[length-1];
                length = 0;
            }
        } 
        else if (state == IN)
        {
            ++length;
        }
        else if (state == OUT)
        {
            state = IN;
            ++length;
        }
    }

    //Print a horizontal histogram of the word counts
    for (i = 0; i < MAX_LENGTH; ++i)
    {
        printf("%2d: ", i + 1);
        for (j = 0; j < word_lengths[i]; ++j)
        {
            printf("*");
        }
        printf("\n");
    }
}

