go_enrich <- read.table("data/go.txt", header =F, sep = "\t",
                        stringsAsFactors =F,fill = TRUE, quote = "")
go_enrich_clear <- go_enrich[3:162,]
colnames(go_enrich_clear) <- c("Term","Database", "ID", "Input.number", "Background.number",
                               "P-Value", "Corrected.P.Value", "Input","Hyperlink")
go_enrich_top <- go_enrich_clear[1:10,]
p <- ggplot(go_enrich_top, aes(x = -log10(Corrected.P.Value), y = Term)) +
    geom_bar(stat = "identity", width = 0.7, fill = "#8DA1CB") + theme_test() +
    labs(title = "The most Enriched GO Terms") +
    theme(axis.text = element_text(size = 12)) +
    scale_y_discrete(labels = function(x) str_wrap(x, width = 30))

print(p)
ggsave("graph/go.pdf")
dev.off()