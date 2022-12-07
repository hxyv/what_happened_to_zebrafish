# RNA enrichment
enriched_trans <- trans2 %>%
    filter(abs(translogFC) >= log2(3)) %>%
    filter(translogFDR > (-log10(0.01))) %>%
    filter(!(transid == ""))
## Add labels
enriched_trans$change <- ifelse(enriched_trans$translogFC > 0, "up", "down")
table(enriched_trans$change)

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
