#Use ggplot to create bar graphs

##Here is the code I used, after converting the taxonomy count table outputs from the previous step into a .csv and imposing cutoffs of counts (for example, not including anything that has a count less than 100)
#all plots are in the plots folder in this repo. 

#######GRAPH 1: SIP_80_2014_all_vents 
##Read in the data table 

library(tidyverse)
library(reshape2) 
library(RColorBrewer)
library(ggplot2)

#read in the count table
SIP_80_2014_tax_table <- read.delim("/Users/sabrinaelkassas/Desktop/output-tax-table_80C_2014_SIP_normalized.txt", header = TRUE, sep = "\t")

#converting to a formatted .csv, so I can impose cutoffs

write.csv(SIP_80_2014_tax_table, /Users/sabrinaelkassas/Desktop/output-tax-table_80C_2014_SIP.csv")

#choose enough colors for the plot
n <- 16
qual_col_pals = brewer.pal.info[brewer.pal.info$category == 'qual',]
col_vector = unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))
pie(rep(1,n), col=sample(col_vector, n))

#ggplot code - 80C 2014
library(ggplot2)
ggplot(SIP_80_2014_tax_table, aes(x = Vent.Site, y = Normalized.Counts, fill = Family)) + 
  geom_bar(stat = "identity", width = 0.5) + theme(axis.text.x.bottom = element_text(angle =
  45)) + scale_fill_manual(values=col_vector)
