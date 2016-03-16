library(MDmisc)
library(annotables)

# Extract coordinates of all genes
# Symbols
fileName <- "all_genes_symbol_hg19.bed"
all_genes_symbol_hg19 <- grch37[ !(is.na(grch37$symbol)) | (grch37$symbol != ""), "symbol"]
promoters <- gr_promoter_extract(selected = unique(all_genes_symbol_hg19$symbol), id = "symbol", upstream = 2000, downstream = 500)
write.table(promoters$promoters, fileName, sep="\t", quote = F, col.names = F, row.names = F)
promoters.count <- system(paste0("bedtools sort -i ", fileName, " | bedtools merge -i - > tmp.bed && mv tmp.bed ", fileName, " && wc -l < ", fileName), intern = TRUE) %>% gsub("\ ", "", x = .)
print(paste0("Promoters extracted for ", promoters.count, " genes. ", length(promoters$notfound), " genes not found."))

# EntrezIDs
fileName <- "all_genes_entrez_hg19.bed"
all_genes_entrez_hg19 <- grch37[ grch37$entrez != "?", "entrez"]
promoters <- gr_promoter_extract(selected = unique(all_genes_entrez_hg19$entrez), id = "entrez", upstream = 2000, downstream = 500)
write.table(promoters$promoters, fileName, sep="\t", quote = F, col.names = F, row.names = F)
promoters.count <- system(paste0("bedtools sort -i ", fileName, " | bedtools merge -i - > tmp.bed && mv tmp.bed ", fileName, " && wc -l < ", fileName), intern = TRUE) %>% gsub("\ ", "", x = .)
print(paste0("Promoters extracted for ", promoters.count, " genes. ", length(promoters$notfound), " genes not found."))

