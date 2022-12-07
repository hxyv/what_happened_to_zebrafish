# Protein enrichment
enriched_protein <- prot %>%
    filter(abs(protlogFC) >= 1) %>%
    filter(protlogFDR > (-log10(0.05)))

## Add labels
enriched_protein$change <- ifelse(enriched_protein$protlogFC > 0, "up", "down")
table(enriched_protein$change)

## Proteins enriched at proximal
proximal_enriched_protein <- enriched_protein %>%
    filter(protlogFC < 0)

## Proteins enriched at distal
distal_enriched_protein <- enriched_protein %>%
    filter(protlogFC > 0)

## Export enriched protein results
write.table(enriched_protein$protid, "data/enriched_protein_id.csv",
            sep = ",", 
            row.names = FALSE, 
            col.names = FALSE, 
            quote = FALSE)

write.table(enriched_protein, "data/enriched_protein.csv",
            sep = ",", 
            row.names = FALSE, 
            col.names = FALSE, 
            quote = FALSE)

write.table(proximal_enriched_protein, "data/proximal_enriched_protein.csv",
            sep = ",", 
            row.names = FALSE, 
            col.names = FALSE, 
            quote = FALSE)

write.table(distal_enriched_protein, "data/distal_enriched_protein.csv",
            sep = ",", 
            row.names = FALSE, 
            col.names = FALSE, 
            quote = FALSE)
