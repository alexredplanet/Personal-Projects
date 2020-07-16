#! usr/bin/env python

# This problem explores permutations as an intro to gene rearrangements

# Given: A positive integer n≤7.
# Return: The total number of permutations of length n, followed by a list of all such permutations
# (in any order).

n = int(input("Enter an integer less than or equal to 7: "))

# Get list of all numbers up and including n
nums = []
for i in range(1,n+1):
    nums.append(i)

import itertools

perms = list(itertools.permutations(nums))

print(len(perms))

for perm in perms:
    for num in perm:
        print(num, end = ' ')
    print()




