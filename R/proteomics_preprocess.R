# Read proteomics file
proteomics <- read.csv("data/PvD_combine.csv")

# Modify meta data
## Filter proteins that do not have gene name.
library(dplyr)
protein_no_geneid <- proteomics %>%
    filter(Gene.Name == "") %>%
    select(Uniprot)

write.table(protein_no_geneid,
            "data/protein_no_geneid.csv",
            sep = ",", 
            row.names = FALSE, 
            col.names = FALSE, 
            quote = FALSE)

## Visit "https://www.uniprot.org/id-mapping" to convert Uniprot id to Gene id, and
## download the file to "data" folder.
## Add gene id to raw data.
protein_with_geneid <- read.csv("data/protein_with_geneid.csv")
n <- nrow(proteomics)
m <- nrow(protein_with_geneid)
for(i in 1:n){
    for(j in 1:m){
        if(proteomics[i,]$Uniprot == protein_with_geneid[j,]$From){
            proteomics[i,]$Gene.Name <- protein_with_geneid[j,]$To
        }
    }
}

## Calculate FC and p-value in excel and read the file again
## Calculate FDR
proteomics$FDR <- p.adjust(proteomics$p.value, method = "BH")

## Save the results.
write.table(proteomics, "data/new_PvD_combine.csv",
            row.names = FALSE, col.names = FALSE, quote = FALSE)

## Generate a new table with less information
prot <- data.frame("protid" = proteomics$Gene.Name,
                   "protlogFC" = proteomics$logFC,
                   "protlogFDR" = (-log10(proteomics$FDR)))




