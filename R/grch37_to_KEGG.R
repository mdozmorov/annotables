library(MDmisc)
library(annotables)
library(KEGG.db)

xx <- as.list(KEGGPATHID2EXTID) # Pathway IDs to EntrezIDs
xx <- xx[ grepl("^hsa", names(xx)) ] # Subset only human pathways
for (i in 1:length(xx)) {
  print(names(xx)[i])
  # Extract enomic coordinates of genes in the corresponding pathway
  genes.bed <- gr_gene_extract(xx[[i]])[[1]]
  write.table(genes.bed, paste0(names(xx)[i], ".bed"), sep="\t", row.names = F, col.names = F, quote = F)
}

# Save pathway annotations
yy <- as.list(KEGGPATHID2NAME)
setdiff(names(xx), paste0("hsa", names(yy))) # Check if any pathway ID is missing
yy <- data.frame(pid=paste0("hsa", names(yy)), description=unlist(yy)) # Convert to data frame
yy <- yy[ yy$pid %in% names(xx), ] # Subset by the hsa IDs
write.table(yy, "hsa_description.txt", sep = "\t", quote = F, row.names = F)
