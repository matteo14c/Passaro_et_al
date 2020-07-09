# Passaro_et_al

Custom Perl utilities, used for the processing of metagenomics assemblies in [Passaro et al 2019](https://www.nature.com/articles/s41598-019-56240-1).  

Please refer to Passaro et al 2019 and XX et al 2020 for a complete description of the computational workflow and of all the commands used to produce the results.  

This repository is intended to provide only custom Perl utilities used in the analysis of the data. Please notice that since the main goal is to reproduce the results attained in the paper, these scripts are not meant to and do not accept any parameters for their execution. The only purpose/aim/utility is to reproduce the analyses of Passaro et al 2019.  

The repository contains 3 main programs:  
  1. **filter.pl** , a simple *Perl* script that reads a fasta file and filters all the sequence with a used defined proportion of masked (N) sites. The proportion is arbitrarily fixed at 15% of the sequence length, to reproduce the parameters used in Passaro et al 2019.  
  2. **simple.parse.blast.pl**, a Perl script to parse a tabular blastn output file to assign metagenomics contigs to an organism and produce descriptive statistics. Contigs are assigned simply by similarity criteria, as defined in Passaro et al 2019. That is: only the best match is considered and only matches that cover 30% of the scaffold sequence with an average sequence identity of 70% or greater are used to assign a scaffold. The final output consists in a simple table, where for every species to which one or more contigs were assigned, the total number of contigs assigned to that species, and their total size is reported. An example is enclosed below:  

|Species Name|# of assigned contigs|total size|
|:---:|:---:|:---:|
|human|513|301243|
|chlorocebus|1|371|
|Nohit|16|5125|
|monkey|90|41487|
|onchocerca_flexuosa|1|127|
|rhesus_macaque|4|3613|

Nohit is used to indicate sequence that show no significant similarity/were not assigned to any species.  

  3. **parse_Vir_map.pl**, this script is used to parse a sam file of reads mapped to assembly of viral genomes as recovered from our metagenomic assemblies, and to identify reads that show partial matches to a viral genome or "broken pairs" of reads that is pairs where only one of the reads could be confidently  assigned to a viral genome assembly. These reads are possible indications of potential integration of a virus in the genome of the host. The program provides 2 distinct output files. The file with the **singleton.fq** suffix contains unmapped reads that have a mate mapped to a viral genome (broken pairs). The file with the **partial.fq** suffix contains reads that show partial similarity to a viral genome assembly.
Possible events of integration of viral genomes in the genome of the host can be identified by mapping **singleton.fq** and **partial.fq**  against a reference assembly of the human genome (Please refer to https://github.com/bfosso/SDATA_bio_Desc, for more detailed instructions on how to map the reads and process the output).  Genomic positions where reads are eventually mapped, should be indicative of the integration site.
Please notice that in the original paper by Passaro et al 2019 no reads or pairs of reads that would support the integration of any virus into the genome of the host could be detected.
