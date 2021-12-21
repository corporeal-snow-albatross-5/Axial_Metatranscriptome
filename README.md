# Axial_Metatranscriptome
## Metatranscriptomics pipeline for Axial Seamount RNA-SIP experiments 

### Axial RNA-SIP Sample Processing: From Raw Reads to OTU Bar Graphs
- scripts are located in the "scripts" folder in this repo. Names of the corresponding scripts are below each overview step. 

#### Overview:
1. Quality Check the files with FastQC and MultiQC  
-fastqc.sh  
-multiqc.sh
2. Trim the reads with Trimmomatic  
-trimmomatic.sh
3. Combine all the forward and all the reverse read segments using cat command  
-cat.sh
4. Combine concatenated forward and reverse reads using Flash  
-flash.sh
5. Run SortMeRNA to remove rRNA from the mRNA  
-sortmerna.sh
6. Use fq2fa from IDBA_UD to convert .fastq output of Mothur to .fasta  
-fq2fa.sh
7. Classify taxonomy of rRNA using Mothur classify.seq  
-mothur.sh
8. Use R to properly format Mothur output  
-R_format.sh
9. Use R to create a count table of taxonomic groups by desired classification (Domain, Kingdom, Phylum, Class, Order, Family, Genus, Species)  
-R_count_table.sh
10. Use ggplot to create bar graphs  
-R_rel_abundance_plot.sh

#### Documentation for each program:
1. FastQC - https://dnacore.missouri.edu/PDF/FastQC_Manual.pdf
2. MultiQC - https://multiqc.info/docs/
3. Flash (Fast Length Adjustment of Short reads) - https://ccb.jhu.edu/software/FLASH/
4. SortmeRNA - https://bioinfo.lifl.fr/RNA/sortmerna/code/SortMeRNA-user-manual-v2.1.pdf 
- https://github.com/biocore/sortmerna
5. fq2fa
6. Mothur - classify.seq
8. R code and directions will be included at the end of the 'Axial RNA-SIP Sample Processing-From Raw Reads to OTU Bar Graphs.pdf' and in the scripts folder

*Note: all of these programs were run on WHOI’s cluster, Poseidon, so the code for that is included. Additionally, all programs were installed using Conda Environments*

### **A full overview of all of the steps is located in the document 'Axial RNA-SIP Sample Processing-From Raw Reads to OTU Bar Graphs.pdf' **
