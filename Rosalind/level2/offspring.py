#!/Users/Amarsing/anaconda3/bin/python

# Given: Six nonnegative integers, each of which does not exceed 20,000.
# The integers correspond to the number of couples in a population possessing
# each genotype pairing for a given factor.
# In order, the six given integers represent the number of couples
# having the following genotypes:
# 1. AA-AA
# 2. AA-Aa
# 3. AA-aa
# 4. Aa-Aa
# 5. Aa-aa
# 6. aa-aa
# Return: The expected number of offspring displaying the
# dominant phenotype in the next generation,
# under the assumption that every couple has exactly two offspring

couples = input("Enter the number of couples per genotype: ").split()
couples = [int(i) for i in couples]


def expected_offspring(couples, offspring, dominant):
    dom = sum([a[0]*a[1]*offspring for a in zip(couples, dominant)])
    return dom


print(expected_offspring(couples, 2, [1, 1, 1, 0.75, 0.5, 0]))
