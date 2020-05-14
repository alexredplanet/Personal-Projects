#!/Users/Amarsing/anaconda3/bin/python

# Computing GC Content

# Given: At most 10 DNA strings in FASTA format (of length at most 1 kbp each).
# Return: The ID of the string having the highest GC-content,
# followed by the GC-content of that string.

# Parse FASTA File

from Bio import SeqIO

gc_cont = {}
for seq_record in SeqIO.parse("rosalind_gc.txt", "fasta"):
    gc = 0

    # Compute GC Content of each sequence

    for char in seq_record.seq:
        if char == 'G' or char == 'C':
            gc += 1
    gc_cont[seq_record.id] = (gc/float(len(seq_record.seq)))*100

# Return the Sequence with highest GC content and the ID

key = max(gc_cont, key=gc_cont.get)
max_gc = gc_cont[key]
print(key)
print(max_gc)
