# Construct the volcano plot
library(cowplot)
library(patchwork)
library(ggplotify)
library(ggplot2)

up <- intersect(which(prot$protlogFDR > (-log10(0.05))), which(prot$protlogFC >= 1))
down <- intersect(which(prot$protlogFDR > (-log10(0.05))), which(prot$protlogFC <= -1))
significant <- rep('normal', times = nrow(prot))
significant[up] <- 'up'
significant[down] <- 'down'
significant <- factor(significant, levels=c('up', 'down', 'normal'))
xline <- c(-1, 1)
yline <- -log(0.05, 10)
p <- qplot(x = prot$protlogFC, y = prot$protlogFDR, xlab = 'logFC', ylab = '-log10(FDR)',
           size = I(0.7), colour = significant, label = prot$protid)+ 
    scale_color_manual(values = c('up' = 'red', 'normal' = 'grey', 'down' = 'blue')) +
    geom_vline(xintercept = xline, lty = 2, size = I(0.2), color = 'grey11') +
    geom_hline(yintercept = yline, lty = 2, size = I(0.2), color = 'grey11') +
    theme_bw() + 
    theme(panel.background = element_rect(color = 'black', size = 1, fill = 'white'),
          panel.grid = element_blank()) 

print(p)
ggsave("graph/prot_volcano.pdf")
dev.off()