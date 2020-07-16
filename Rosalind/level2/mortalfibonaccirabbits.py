#! usr/bin/env python

# Mortal Fibonacci Rabits using Dynamic Programming

# CONDITIONS
# The population begins in the first month with a pair of newborn rabbits.
# Rabbits reach reproductive age after one month.
# In any given month, every rabbit of reproductive age mates with another
# rabbit of reproductive age.
# Exactly one month after two rabbits mate, they produce one male and one
# female rabbit.
# Rabbits live for m <= 20 months long

# Task
# Calculate how many rabbit pairs remain after n <= 100 generations

n = 101
m = 21

while(n > 100 or m > 20):
    try:
        n = int(input("Number of generations (<= 100): "))
        m = int(input("Rabbits lifespan (months, <= 20): "))
    except:
        print("Integer values only.")

rabbits = [1] * n  # Initialise list

for i in range(2, n):
    R_n = rabbits[i-1]      # Reproductive Rabbit pairs this month
    NR_n = rabbits[i-2]     # Non-Reproductive rabbit pairs this month
    if i-m > 0:
        DR_n = rabbits[i-m]
        T_n = R_n + NR_n - DR_n # Total number of pairs including deaths
    else:
        T_n = R_n + NR_n        # Total Number of rabbit pairs this month
    rabbits[i] = T_n        # Add the total to the rabbits list

print(rabbits[-1])