# Passaro_et_al
custom Perl utilities, used for the processing of metagenomics assemblies in Passaro et al 2019. 

Please refer to Passaro et al 2019 and XX et al 2020 for a complete description of the computational workflow and of all the commands used to produce the results

This repository is intended to provide only custom Perl utilities used in the analysis of the data. Please notice that since the main goal is to reproduce the results attained in the paper, these scripts are not meant to and do not accept any parameters for their execution. The only purpose/aim/utility is to reproduce the analyses of Passaro et al 2019

The repository contains 2 main programs.
1: filter.pl , a simple per script that reads a fasta file and filters all the sequence with a used defined proportion of masked (N) sites. The proportion is arbitrarily fixed at 15% of the sequence length, to reproduce the parameters used in Passaro et al

2: simple.parse.blast.pl, a Perl script to parse a tabular blastn output file to assign metagenomics contigs to an organism and produce descriptive statistics. Contigs are assigned simply by similarity criteria, as defined in Passaro et al. That is: only the best match is considered and  only matches that cover 30% of the scaffold sequence with an average sequence identity of 70% or greater are used to assign a scaffold. The final output consists in a simple table, where for every species to which one or more contigs were assigned, the total number of contigs assigned to that species, and their total size is reported.
An example is enclosed below:

human 513	301243
chlorocebus	1	371
Nohit	16	5125
monkey	90	41487
onchocerca_flexuosa	1	127
rhesus_macaque	4	3613

Nohit is used to indicate sequence that show no significant similarity/were not assigned to any species
