#! usr/bin/env/python

#Given: Two positive integers k (k≤7) and N (N≤2k). In this problem, we begin with #Tom, who in the 0th generation has genotype Aa Bb. Tom has two children in the 1st #generation, each of whom has two children, and so on. Each organism always mates with #an organism having genotype Aa Bb.

#Return: The probability that at least N Aa Bb organisms will belong to the k-th #generation of Tom's family tree (don't count the Aa Bb mates at each level). Assume #that Mendel's second law holds for the factors.

# Note:
# For Y in {AABB, AABb, AAbb, AaBB, AaBb, Aabb, aaBB, aaBb, aabb}
# given a mating of any Y x AaBb, 
# the probability of having an AaBb offspring is always 1/4
# You can verify this with punnet squares.
# To calculate the probability, we then take the binomial distribution from n to the # # total number of offspring

from decimal import *
import math
getcontext()

# Get User Input
k = int(input("Enter the no. of generations: "))
offspring = 2**k

while (True):
    n = int(input("Enter the no. of offspring: "))
    if n > offspring:
        print("Enter a number that is less than or equal to", offspring)
    else:
        break

# Calculate probability
prob = sum([Decimal((math.factorial(offspring)/(math.factorial(x)*math.factorial(offspring - x))))*Decimal((0.25**x)*(0.75**(offspring-x))) for x in range(n, offspring+1)])
print(prob)



