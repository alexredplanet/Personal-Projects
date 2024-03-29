#!/Users/Amarsing/anaconda3/bin/python

# This file transcribes a DNA string into RNA

dna = "AATTATGATCCAGTTTGCCATCCCGATTGACCACGTCATAAATCGGTGGCTAGCCGGTGGACTTGCATACCAACAATTCGGACGCATCTCCAATGGCGTATAAAAGCCTAGAAGTTGTCCCTAATGCTGACATACCGAACGATACAGTTGTGTCTTTCTCGATAACTGGCAATCTTAGCTCGGCGCAAGAAATGTTTCCAGGATACACTCTCAGACTTATTGCTGGATGTTAGGCAAGTAATTTTCAATGATATGGTGAACCTTCAAAACAGATATTGATCTAGCATAGTCACCTAAGCGTTCTGAGGTCTCAGCCGATAGGACTGGTGAACAACTCGCCGTCATTCCAATCCGAGTGGTATCCCATTTAGACCCGTGGGAGACTAAATACAATACCGCAGTCTGTGTTAACAAGCTTCGTTCCTTCCACAACTGACCTGATCACCGCGGGAGTAACGCCTGAGCGACATTATGCTATGCAGAACACAGAGTGGGGACGTCGCTTTATCCTACAGACAGGGTTGTGGATACATCTTGCTCTCGTCCGCACGATCTGCAATCATTGTGCCGACCGGATTGGCAGTATTATCCAGACACACAGCCCGAAATCTGAGGTGATAACCGAATCCCCGAAAGCTTAGCCTCATCCCCGATAACTATGCAGAAACCCGACTGACTAGACATACAGTGGACCGCAGCTCCTCATGAATGGTGCTTTGGTACTGTAGAGCGTTGGGTCGTTCCTGTGAGAGGACTAGTAGGCTCCGATAGTACTGGCTGGCCGTGATGGGCTTCGCGGTGCGAGATATGATATCCAGCTTTAGACCACGAGGACCACTAGATCACCTTTGCGCACCGCATAGGCCTGCTGGAAAGGGCTTAACTACCTGGAGGTAACCTCGCTACTGGCGGTGTTGGGTATCTACCGCTAGGGGTCACGTGGTTGCCCATGATATGCGCTTGCGTAGCG"
rna = ''

for base in dna:
    if base == 'T':
        rna = rna + 'U'
    else:
        rna = rna + base

print(rna)