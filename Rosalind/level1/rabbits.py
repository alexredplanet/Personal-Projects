#!/Users/Amarsing/anaconda3/bin/python

# Rabbits and Recurrence Relations

# CONDITIONS
# The population begins in the first month with a pair of newborn rabbits.
# Rabbits reach reproductive age after one month.
# In any given month, every rabbit of reproductive age mates with another
# rabbit of reproductive age.
# Exactly one month after two rabbits mate, they produce one male and one
# female rabbit.
# Rabbits never die or stop reproducing.

# TASK
# Find the total number of rabbit pairs that will be present after n months,
# if we begin with 1 pair and in each generation,
# every pair of reproduction-age rabbits produces a litter of k rabbit pairs
# (instead of only 1 pair).

# Get values for n and k
n = int(input("Enter a value for n: "))

if n == 0 or n == 1:
    print(1)
    exit()
k = int(input("Enter a value for k:"))

rabbits = [1] * n  # Initialise list

for i in range(2, n):
    R_n = rabbits[i-1]      # Reproductive Rabbit pairs this month
    NR_n = rabbits[i-2]*k   # Non-Reproductive rabbit pairs this month
    T_n = R_n + NR_n        # Total Number of rabbit pairs this month
    rabbits[i] = T_n        # Add the total to the rabbits list

print(rabbits[-1])
