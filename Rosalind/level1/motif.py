#!/Users/Amarsing/anaconda3/bin/python

# Given: Two DNA strings s and t (each of length at most 1 kbp).
# Return: All locations of t as a substring of s.

seq = input("Enter a DNA string: ")
sub = input("Enter a substring: ")


# String String EMPTY List --> List

def substring_positions(string, sub):
    previous_index = -1
    while True:
        previous_index = string.find(sub, previous_index + 1)
        if previous_index == -1:
            break
        yield previous_index + 1


print(*list(substring_positions(seq, sub)), sep=' ')
