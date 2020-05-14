#!/Users/Amarsing/anaconda3/bin/python

# Given: A protein string P of length at most 1000 aa.
# Return: The total weight of P. Consult the monoisotopic mass table.

# Read AA to Mass Table in as Dict.

with open("atomicmass.txt", "r") as f:
    aa_to_mass = {}
    for row in f:
        AA, mass = row.split()
        aa_to_mass[AA] = float(mass)

with open("rosalind_prtm.txt", "r") as f:
    protein = f.read().replace('\n', '')

# The monoisotopic mass of water is considered to be 18.01056 Da
atomic_mass = 0
for i in range(0, len(protein)):
    for AA in aa_to_mass:
        if AA == protein[i]:
            atomic_mass = atomic_mass + aa_to_mass[AA]

print(atomic_mass)
