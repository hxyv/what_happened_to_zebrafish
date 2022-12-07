# Read the transcriptomics data.
trans <- read.csv("data/PvD_trans.csv")

## Generate a new table with less information
library(dplyr)
trans2 <- data.frame("transid" = trans$symbol,
                   "translogFC" = trans$log2FoldChange,
                   "translogFDR" = (-log10(trans$FDR))) 

