#!/Users/Amarsing/anaconda3/bin/python

# This file uses the fibonacci estimation of rabbit mating to determine rabbit population after n months

months = 5  # The number of months
pairs = 3  # The number of litter pairs produced by each reproductive pair per month

rabbit_pairs = 1  # At month 0 there are 2 rabbits

# Note it takes 1 month for each new litter to reach reproductive age
for month in range(1, months):
    rabbit_pairs = rabbit_pairs * 3

