# Filter genes in both transcripts and proteomics.
gene_intersect <- merge(enriched_protein, enriched_trans, all.y = TRUE) %>%
    filter(transid == protid) %>%
    select(transid, translogFC, translogFDR, protlogFC, protlogFDR)

## Show results in a table.
intersect_gene_table <- data.frame("Gene" = gene_intersect$transid,
                         "logFC RNA" = gene_intersect$translogFC,
                         "FDR RNA" = 10 ^ (- gene_intersect$translogFDR),
                         "logFC protein" = gene_intersect$protlogFC,
                         "FDR protein" = 10 ^ (- gene_intersect$protlogFDR))
write.table(intersect_gene_table, "data/intersect_gene_table.csv",
          sep = ",", 
          row.names = FALSE, 
          col.names = FALSE, 
          quote = FALSE)

# Gene enriched in prixomal
proximal_enriched <- intersect_gene_table %>%
    filter(logFC.RNA < 0)

write.table(proximal_enriched, "data/proximal_enriched.csv",
            sep = ",", 
            row.names = FALSE, 
            col.names = FALSE, 
            quote = FALSE)

# Gene enriched in distal
distal_enriched <- intersect_gene_table %>%
    filter(logFC.RNA > 0)

write.table(distal_enriched, "data/distal_enriched.csv",
            sep = ",", 
            row.names = FALSE, 
            col.names = FALSE, 
            quote = FALSE)
