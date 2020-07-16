#!/Users/Amarsing/anaconda3/bin/python

# Given: An RNA string s corresponding to a strand of mRNA
# (of length at most 10 kbp).
# Return: The protein string encoded by s.

# Read RNA to AA Table in as Dict.

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

with open("rosalind_prot.txt", "r") as f:
    RNA = f.read().replace('\n', '')
protein = ""

for i in range(0, len(RNA), 3):
    for AA in codon_to_aa:
        if RNA[i:i+3] in codon_to_aa[AA]:
            if AA != 'Stop':
                protein = protein + AA

with open("rnatoprotein_out.txt", "w") as f:
    f.write("RNA Sequence: \n{!s}" .format(RNA))
    f.write("\n\nProtein Sequence: \n{!s}" .format(protein))
