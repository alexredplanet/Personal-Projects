#!/usr/bin/env python

#Given: A DNA string s (of length at most 1 kbp) and a collection of substrings of s acting as introns. All strings are given in FASTA format.
#Return: A protein string resulting from transcribing and translating the exons of s. (Note: Only one solution will exist for the dataset provided.)

# Fasta File (s, subs) (DNA) -> String (Translated to protein)
# Delete the introns (subs) from a sequence (s), and then translate to protein using the most common codons for an AA

from Bio import SeqIO  #Useful to parse FASTA files
from Bio.Seq import Seq  #Useful to parse FASTA files
from Bio.Alphabet import generic_dna #for creating DNA seq object

sequences = (SeqIO.parse("rnasplicing.fasta", "fasta"))

# Get first seq obect (DNA to be spliced)
dna_sequence = str(sequences.__next__().seq)

# Remove all other substrings from seq
for sub in sequences:
    dna_sequence = dna_sequence.replace(str(sub.seq), "")

# Convert stipped DNA seq back to a Seq Object
# Translate and don't print the final "*" char used for stop codons
print(Seq(dna_sequence,generic_dna).translate()[:-1])

