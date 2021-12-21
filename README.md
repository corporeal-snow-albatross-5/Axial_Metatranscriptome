# Axial_Metatranscriptome
## Metatranscriptomics pipeline for Axial Seamount RNA-SIP experiments 

### Axial RNA-SIP Sample Processing: From Raw Reads to OTU Bar Graphs

#### Overview:
1. Quality Check the files with FastQC and MultiQC
2. Trim the reads with Trimmomatic
3. Combine all the forward and all the reverse read segments using cat command
4. Combine concatenated forward and reverse reads using Flash 
5. Run SortMeRNA to remove rRNA from the mRNA
6. Classify taxonomy of rRNA using Mothur classify.seq
7. Use fq2fa from IDBA_UD to convert .fastq output of Mothur to .fasta
8. Use R to properly format Mothur output
9. Use R to create a count table of taxonomic groups by desired classification (Domain, Kingdom, Phylum, Class, Order, Family, Genus, Species)
10. Use ggplot to create bar graphs

#### Documentation for each program:
1. FastQC - https://dnacore.missouri.edu/PDF/FastQC_Manual.pdf
2. MultiQC - https://multiqc.info/docs/
3. Flash (Fast Length Adjustment of Short reads) - https://ccb.jhu.edu/software/FLASH/
4. SortmeRNA - https://bioinfo.lifl.fr/RNA/sortmerna/code/SortMeRNA-user-manual-v2.1.pdf 
- https://github.com/biocore/sortmerna
5. Mothur - classify.seq
6. fq2fa
7. R code and directions will be included at the end of this document 

*Note: all of these programs were run on WHOI’s cluster, Poseidon, so the code for that is included. Additionally, all programs were installed using Conda Environments*

### **A full overview of all of the steps is located in the document 'Axial RNA-SIP Sample Processing-From Raw Reads to OTU Bar Graphs.pdf' **
