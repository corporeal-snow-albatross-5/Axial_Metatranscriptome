#Use R to create a count table of taxonomic groups by desired classification (Domain, Kingdom, Phylum, Class, Order, Family, Genus, Species)**

#Again, I will paste an example of my code and slurm script. It is easily adaptable to properly formatted .csv's. 

#for loop to import rRNA read taxonomy assignments
##Input path to all data files
##07/30/21

#install packages
library(tidyverse)

#Set up files
#select correct files for HPC
taxa_raw <- list.files(path = 
"/vortexfs1/scratch/selkassas/qc-trim/raw_data/rRNA_files/rRNA_fasta_files/other_tax/taxonomy_files_for_r/80C_2014_SIP_for_figures", pattern = "wang.taxonomy.NEW.csv", full.names = FALSE)

#path to files for HPC
path_data <- "/vortexfs1/scratch/selkassas/qc-trim/raw_data/rRNA_files/rRNA_fasta_files/other_tax/taxonomy_files_for_r/80C_2014_SIP_for_figures/"

#For loop

for(a in taxa_raw){
  #import files, use paste to string together path and file names
  imported_tax <- read.csv(paste(path_data, a, sep = ""))
  #Extract sample name from "a", and split at ".wang"
  sample_names <- unlist(strsplit(a, ".wang"))
  #Modify imported data
  output_tmp <- imported_tax %>%
  #Adding in the sample name
  mutate(SAMPLE = sample_names[1]) %>%
    #filter out unknowns
    filter(!(grepl("unknown_unclassified", x))) %>%
    select(useful = x) %>%
    separate(useful, into = c("ACCESSION_NUMBER", "taxonomy"), sep = "\t") %>%
    # use regex to modify taxonomy column
    mutate(new_tax = str_replace_all(taxonomy, pattern = "\\(\\d+\\)", replacement = "")) %>%
    # parse taxonomy lineage name by semicolon
    separate(new_tax, 
             into = c("Domain", "Phylum", "Class", "Order", "Family", "Genus", "Species"), sep = ";") %>%
    # add artifical count column
    add_column(COUNT = 1) %>%
    # add sample information
  group_by(sample_names[1], Phylum, Class, Order, Family, Genus, Species) %>%
    summarise(SUM = sum(COUNT))
  cat("Processing...", sample_names[1], "/n/n")
  # if else statement to facilitate row bind
  if (!exists("tax_table")){
    tax_table <- output_tmp
  } else {
    tax_table <- bind_rows(tax_table, output_tmp)
  }
  rm(output_tmp)
}

#rm(output_tmp)
#run the rm(tax_table) every time you run the for-loop so it doesn't add files twice.
#rm(tax_table)

write_delim(tax_table, file  = "output-tax-table_80C_2014_SIP.txt", delim = "\t")


####SLURM SCRIPT

#!/bin/bash
#SBATCH --partition=compute                  # Queue selection
#SBATCH --job-name=80C_2014_SIP              # Job name
#SBATCH --mail-type=ALL                      # Mail events (BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=elks@mit.edu             # Where to send mail
#SBATCH --ntasks=1                           # Run a single task
#SBATCH --cpus-per-task=36                   # Number of CPU cores per task
#SBATCH --mem=100gb                          # Job memory request
#SBATCH --time=24:00:00                      # Time limit hrs:min:sec
#SBATCH --output=80C_2014_SIP.log            # Standard output/error
#export OMP_NUM_THREADS=8

module load anaconda/5.1

source activate R_environment

cd /vortexfs1/scratch/selkassas/qc-trim/raw_data/rRNA_files/rRNA_fasta_files/other_tax/taxonomy_files_for_r/80C_2014_SIP_for_figures

Rscript rRNA-tax-loop.R
