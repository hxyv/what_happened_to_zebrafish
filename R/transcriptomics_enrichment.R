# RNA enrichment
enriched_trans <- trans2 %>%
    filter(abs(translogFC) >= log2(3)) %>%
    filter(translogFDR > (-log10(0.01))) %>%
    filter(!(transid == ""))

## Add labels
enriched_trans$change <- ifelse(enriched_trans$translogFC > 0, "up", "down")
table(enriched_trans$change)

## RNA enriched at proximal
proximal_enriched_trans <- enriched_trans %>%
    filter(translogFC < 0)

## Proteins enriched at distal
distal_enriched_trans <- enriched_trans %>%
    filter(translogFC > 0)

## Export RNA enrichment results
write.table(enriched_trans$transid, "data/enriched_trans_id.csv",
            sep = ",", 
            row.names = FALSE, 
            col.names = FALSE, 
            quote = FALSE)

write.table(enriched_trans, "data/enriched_trans.csv",
            sep = ",", 
            row.names = FALSE, 
            col.names = FALSE, 
            quote = FALSE)

write.table(proximal_enriched_trans, "data/proximal_enriched_trans.csv",
            sep = ",", 
            row.names = FALSE, 
            col.names = FALSE, 
            quote = FALSE)

write.table(distal_enriched_trans, "data/distal_enriched_trans.csv",
            sep = ",", 
            row.names = FALSE, 
            col.names = FALSE, 
            quote = FALSE)
