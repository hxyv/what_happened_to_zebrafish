library(clusterProfiler)
library(stringr)
pathway<-read.table("data/kegg.txt",header =F, sep = "\t",
                    stringsAsFactors =F,fill = TRUE)
colnames(pathway)=c("Term","Database","ID","Input.number","Background.number",
                    "P-Value","Corrected.P.Value","Input","Hyperlink")
kegg_pathway=pathway[1:52,]
kegg_pathway$richFactor<-kegg_pathway$Input.number/kegg_pathway$Background.number
kegg_top<-kegg_pathway[1:15,]
library(ggplot2)
colnames(kegg_top)
p<-ggplot(kegg_top,aes(x=richFactor,y=Term)) +
    geom_point(aes(size=Input.number,color= Corrected.P.Value))+
    scale_color_gradient(low="red",high="green")+
    labs(title="Statistics of Pathway Enrichment",x="Rich factor", y="", 
         color= "qvalue",size="Gene_number")+theme_bw() +
    theme(axis.text = element_text(size = 12)) +
    scale_y_discrete(labels = function(x) str_wrap(x, width = 30))

print(p)
ggsave("graph/kegg.pdf")
dev.off()
