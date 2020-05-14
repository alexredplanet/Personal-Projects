#! usr/bin/env python

# Read in the codon table as a python dictionary

with open("rnacodon.txt", "r") as f:
    codon_to_aa = {}
    for row in f:
        codon, AA = row.split()
        if AA not in codon_to_aa:
            codon_to_aa[AA] = codon
        elif type(codon_to_aa[AA]) == list:
            codon_to_aa[AA].append(codon)
        else:
            codon_to_aa[AA] = [codon_to_aa[AA], codon]

with open('mRNA-from-protein.txt', 'r') as file:
    protein_seq = file.read().replace('\n', '')
protein_seq = protein_seq + "*"



possible_rna=1
for char in protein_seq:
    if type(codon_to_aa[char]) == list:
        possible_rna = possible_rna*len(codon_to_aa[char])%1000000
    else:
        possible_rna = possible_rna%1000000

print(possible_rna)



