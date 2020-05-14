#!/Users/Amarsing/anaconda3/bin/python

# Counting Point Mutations

# Given two strings s and t of equal length,
# the Hamming distance between s and t, denoted dH(s,t),
# is the number of corresponding symbols that differ in s and t

# Task
# Given: Two DNA strings s and t of equal length (not exceeding 1 kbp).
# Return: The Hamming distance dH(s,t).

s = input("Enter a DNA string: ")
t = input("Enter another DNA string of Equal Length: ")


def hamm(s, t):
    count = 0
    for i, char in enumerate(s):
        if t[i] != char:
            count += 1
    return count


print(hamm(s, t))
