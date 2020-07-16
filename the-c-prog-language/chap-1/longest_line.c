/* This program returns the length of the longest line given in input, and as much of the text as possible. The line may be arbitrarily long*/

#include <stdio.h>

#define MAXLINE 1000

int get_line(char s[], int lim);
void copy(char to[], char from[]);

int main()
{
    int len;
    int max;
    char line[MAXLINE];
    char longest[MAXLINE];

    max = 0;
    while((len = get_line(line, MAXLINE)) > 0)
    {
        if (max >= MAXLINE && line[len-1] != '\n')
        {
            max = max + len;
            copy(longest, line);
        }
        else if (len > max)
        {
            max = len;
            copy(longest, line);
        }
    }
    if (max > 0)
    {
        printf("%s", longest);
    }
    return 0;
}

/*getline: Read a line into s, return length*/
int get_line(char s[], int lim)
{
    int c, i;

    for (i=0; i<lim-1 && (c=getchar())!= EOF && c!= '\n'; ++i)
    {
        s[i] = c;
    }
    if (c == '\n')
    {
        s[i] = c;
        ++i;
    }
    s[i] = '\0';
    return i;
}

/*copy: copy 'from' into 'to'; assume to is big enough*/
void copy(char to[], char from[])
{
    int i;
    i = 0;
    while ((to[i] = from[i]) != '\0')
        ++i;
}