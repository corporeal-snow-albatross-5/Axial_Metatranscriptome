## Use R to properly format Mothur output**

##I will just show an example of this, and you can use the code to process yours.
#This ensures that the .csv file, which we will input into our count table is properly formatted. The count table code WILL NOT work unless this code is run first. Input file is the taxonomy output (not the tax.summary file) file from Mothur. 

##80C 2014 All Locations

install.packages(tidyverse)
library(tidyverse)

bad906 <- read.csv("~/OneDrive - Massachusetts Institute of Technology/Notebooks/R with Sarah/80C_2014_SIP_for_figures/FS906_80_TP1_13H_AAGGGA_L006_trim_paired_merged_rRNA.nr_v132.w
ang.taxonomy.csv", header = FALSE)
bad907 <- read.csv("~/OneDrive - Massachusetts Institute of Technology/Notebooks/R with Sarah/80C_2014_SIP_for_figures/FS907_80_13H8_TTCAGC_L001_trim_paired_merged_rRNA.nr_v132.wang
.taxonomy.csv", header = FALSE)
bad908 <- read.csv("~/OneDrive - Massachusetts Institute of Technology/Notebooks/R with Sarah/80C_2014_SIP_for_figures/FS908_80_TP1_13H_GGATGT_L006_trim_paired_merged_rRNA.nr_v132.w
ang.taxonomy.csv", header = FALSE)

FS906 <- bad906 %>% filter(!is.na(V1)) %>% 
  select(x = V1)
FS907 <- bad907 %>% filter(!is.na(V1)) %>% 
  select(x = V1)
FS908 <- bad908 %>% filter(!is.na(V1)) %>% 
  select(x = V1)

write.csv(FS906, "/Users/sabrinaelkassas/OneDrive\ -\ Massachusetts/ Institute\of\Technology/Notebooks/R\with\Sarah/80C_2014_SIP_for_figures/FS906_80_TP1_13H_AAGGGA_L006_trim_paired_merged_rRNA.nr_v132.wang.taxonomy.NEW.csv")
write.csv(FS907,"/vortexfs1/scratch/selkassas/qc-trim/raw_data/rRNA_files/rRNA_fasta_files/other_tax/taxonomy_files_for_r/80C_2014_SIP_for_figures/FS907_80_13H8_TTCAGC_L001_trim_paired_merged_rRNA.nr_v132.wang.taxonomy.NEW.csv")
write.csv(FS908, "/vortexfs1/scratch/selkassas/qc-trim/raw_data/rRNA_files/rRNA_fasta_files/other_tax/taxonomy_files_for_r/80C_2014_SIP_for_figures/FS908_80_TP1_13H_GGATGT_L006_trim_paired_merged_rRNA.nr_v132.wang.taxonomy.NEW.csv")
