#!/Users/Amarsing/anaconda3/bin/python

# Mendel's First Law

# Given: Three positive integers k, m, and n, representing a population
# containing k+m+n organisms:
# k individuals are homozygous dominant for a factor
# m are heterozygous, and n are homozygous recessive.

# Return: The probability that two randomly selected mating organisms
# will produce an individual possessing a dominant allele
# (and thus displaying the dominant phenotype).
# Assume that any two organisms can mate.

# Get user Input

k = float(input("Enter a value for k:"))
m = float(input("Enter a value for m:"))
n = float(input("Enter a value for n:"))

# Define prob_dom function
# Float Float Float --> Float (probability)
# Determine the chance of 1 dominant allele being present in offspring
# Based on Mendel's Laws


def prob_dom(k, m, n):
    p = k + m + n
    prob_mn = (m/p * n/(p-1)) + (n/p * m/(p-1))
    prob_nn = (n/p * (n-1)/(p-1))
    prob_mm = (m/p * (m-1)/(p-1))
    # prob of at least 1 Dominant = 1 - prob of no dominants
    # By Mendel's laws, mating of hetero. with homo. rec. contains no dominants
    # in half the offspring
    prob = 1 - prob_nn - prob_mn/2 - prob_mm/4
    print(prob)


prob_dom(k, m, n)
